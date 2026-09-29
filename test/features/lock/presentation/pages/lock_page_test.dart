import 'dart:async';

import 'package:drift/native.dart';
import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/lock/data/datasources/device_security_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/pin_hasher.dart';
import 'package:expense_tracker/features/lock/data/lock_providers.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drift work is scheduled on the widget test's fake clock, so awaiting it
/// directly never completes: pump until [future] is done instead.
Future<T> pumpUntilDone<T>(WidgetTester tester, Future<T> future) async {
  late T result;
  Object? error;
  var done = false;
  unawaited(
    future.then(
      (value) {
        result = value;
        done = true;
      },
      onError: (Object e) {
        error = e;
        done = true;
      },
    ),
  );
  for (var i = 0; i < 100 && !done; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  if (error != null) throw error!;
  if (!done) fail('future did not complete');
  return result;
}

/// Lets queued drift writes and stream re-queries run, then settles frames.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
  await tester.pumpAndSettle();
}

class FakeBiometric implements BiometricDataSource {
  bool accept = false;
  int prompts = 0;

  @override
  Future<bool> available() async => true;

  @override
  Future<bool> authenticate(String reason) async {
    prompts++;
    return accept;
  }
}

class FakeWindow implements SecureWindowDataSource {
  @override
  Future<void> setSecure({required bool secure}) async {}
}

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late FakeBiometric biometric;
  late ProviderContainer container;
  late Map<String, String> stored;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock(DateTime(2026, 9, 29, 15));
    biometric = FakeBiometric();
    stored = {};
    FlutterSecureStorage.setMockInitialValues(stored);
  });

  /// Like main(): the lock state is known before the first frame.
  Future<void> pumpApp(
    WidgetTester tester, {
    String? pin,
    bool biometricOn = false,
    Size size = const Size(400, 900),
    double textScale = 1,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(clock),
        pinHasherProvider.overrideWithValue(
          const PinHasher(iterations: 1000, inBackground: false),
        ),
        biometricDataSourceProvider.overrideWithValue(biometric),
        secureWindowDataSourceProvider.overrideWithValue(FakeWindow()),
      ],
    );
    if (pin != null) {
      await pumpUntilDone(
        tester,
        container.read(lockRepositoryProvider).setPin(pin),
      );
      if (biometricOn) stored['lock.biometric'] = 'true';
    }
    await pumpUntilDone(tester, container.read(appLockProvider.future));
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: const App()),
    );
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    container.dispose();
    await pumpUntilDone(tester, db.close());
  }

  String location() => container.read(appRouterProvider).state.uri.toString();

  Future<void> type(WidgetTester tester, String digits) async {
    for (final d in digits.split('')) {
      await tester.tap(find.byKey(ValueKey(KeypadKey.digit(int.parse(d)))));
      await tester.pump();
    }
    await settle(tester);
  }

  testWidgets('no PIN: straight to Home', (tester) async {
    await pumpApp(tester);
    expect(location(), '/');
    expect(find.text('Unlock'), findsNothing);
    await dispose(tester);
  });

  testWidgets('a PIN: the lock screen first, Home after the PIN', (
    tester,
  ) async {
    await pumpApp(tester, pin: '1234');
    expect(location(), '/lock?from=%2F');
    expect(find.text('Unlock'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing, reason: 'nothing shows');
    await type(tester, '12');
    expect(find.bySemanticsLabel('2 of 4 digits entered'), findsOneWidget);
    await type(tester, '34');
    expect(location(), '/');
    expect(find.text('Good afternoon'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('wrong PINs, then a 30 s wait', (tester) async {
    await pumpApp(tester, pin: '1234');
    await type(tester, '0000');
    expect(
      find.text('Wrong PIN. 4 more tries before a short wait.'),
      findsOneWidget,
    );
    for (var i = 0; i < 4; i++) {
      await type(tester, '0000');
    }
    expect(find.text('Too many tries. Try again in 30 s.'), findsOneWidget);
    await type(tester, '1234');
    expect(
      location(),
      startsWith('/lock'),
      reason: 'keys ignored while waiting',
    );

    clock.current = clock.current.add(const Duration(seconds: 31));
    await tester.pump(const Duration(seconds: 31));
    expect(find.text('Too many tries. Try again in 30 s.'), findsNothing);
    await type(tester, '1234');
    expect(location(), '/');
    await dispose(tester);
  });

  testWidgets('locks again on return after the timeout, then goes back', (
    tester,
  ) async {
    await pumpApp(tester, pin: '1234');
    await type(tester, '1234');
    await tester.tap(find.text('Activity'));
    await settle(tester);
    expect(location(), '/activity');

    Future<void> leaveFor(Duration away) async {
      for (final state in [
        AppLifecycleState.inactive,
        AppLifecycleState.hidden,
        AppLifecycleState.paused,
      ]) {
        tester.binding.handleAppLifecycleStateChanged(state);
      }
      clock.current = clock.current.add(away);
      for (final state in [
        AppLifecycleState.hidden,
        AppLifecycleState.inactive,
        AppLifecycleState.resumed,
      ]) {
        tester.binding.handleAppLifecycleStateChanged(state);
      }
      await settle(tester);
    }

    await leaveFor(const Duration(seconds: 30));
    expect(location(), '/activity', reason: 'under the 1 minute default');
    await leaveFor(const Duration(minutes: 2));
    expect(location(), '/lock?from=%2Factivity');
    await type(tester, '1234');
    expect(location(), '/activity');
    await dispose(tester);
  });

  testWidgets('biometric unlock prompts by itself', (tester) async {
    biometric.accept = true;
    await pumpApp(tester, pin: '1234', biometricOn: true);
    expect(biometric.prompts, 1);
    expect(location(), '/');
    await dispose(tester);
  });

  testWidgets('a cancelled prompt leaves the PIN and a fingerprint button', (
    tester,
  ) async {
    await pumpApp(tester, pin: '1234', biometricOn: true);
    expect(location(), startsWith('/lock'));
    expect(biometric.prompts, 1);
    await tester.tap(find.byKey(const ValueKey('biometric-unlock')));
    await settle(tester);
    expect(biometric.prompts, 2);
    await tester.tap(find.text('Forgot PIN?'));
    await settle(tester);
    expect(find.textContaining("PIN can't be recovered"), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('More → App lock: set a PIN, then change it', (tester) async {
    await pumpApp(tester, size: const Size(400, 1400));
    await tester.tap(find.text('More'));
    await settle(tester);
    expect(
      find.descendant(
        of: find.widgetWithText(ListTile, 'App lock'),
        matching: find.text('Off'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('App lock'));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('lock-switch')));
    await settle(tester);

    expect(find.text('Choose a PIN'), findsOneWidget);
    await type(tester, '1357');
    await tester.tap(find.byKey(const ValueKey('pin-continue')));
    await settle(tester);
    expect(find.text('Enter the PIN again'), findsOneWidget);
    await type(tester, '1357');
    expect(find.text('App lock is on'), findsOneWidget);
    expect(location(), '/more/lock');
    expect(
      tester
          .widget<SwitchListTile>(find.byKey(const ValueKey('lock-switch')))
          .value,
      isTrue,
    );

    // Let the snackbar go; it covers the bottom of the screen.
    await tester.pump(const Duration(seconds: 5));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('lock-change-pin')));
    await settle(tester);
    expect(find.text('Enter your current PIN'), findsOneWidget);
    await type(tester, '1357');
    await type(tester, '24680');
    await tester.tap(find.byKey(const ValueKey('pin-continue')));
    await settle(tester);
    await type(tester, '24680');
    expect(find.text('PIN changed'), findsOneWidget);
    expect(stored['lock.pin_length'], '5');
    await dispose(tester);
  });

  testWidgets('lock timeout choice is saved', (tester) async {
    await pumpApp(tester, pin: '1234');
    await type(tester, '1234');
    unawaited(container.read(appRouterProvider).push('/more/lock'));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('lock-timeout')));
    await settle(tester);
    await tester.tap(find.text('5 minutes away'));
    await settle(tester);
    expect(stored['lock.timeout'], 'minutes5');
    expect(find.text('5 minutes away'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('lock screen and PIN setup fit at 360 dp and 200% font', (
    tester,
  ) async {
    await pumpApp(
      tester,
      pin: '1234',
      size: const Size(360, 720),
      textScale: 2,
    );
    expect(tester.takeException(), isNull);
    await type(tester, '1234');
    unawaited(
      container.read(appRouterProvider).push('/more/lock/pin?mode=change'),
    );
    await settle(tester);
    expect(find.text('Enter your current PIN'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await dispose(tester);
  });
}
