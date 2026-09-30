import 'dart:async';

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/onboarding/presentation/providers/onboarding_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Drift work is scheduled on the widget test's fake clock, so awaiting it
/// directly never completes: pump until [future] is done instead.
Future<T> pumpUntilDone<T>(WidgetTester tester, Future<T> future) async {
  late T result;
  var done = false;
  unawaited(
    future.then((value) {
      result = value;
      done = true;
    }),
  );
  for (var i = 0; i < 100 && !done; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  if (!done) fail('future did not complete');
  return result;
}

void main() {
  late AppDatabase db;
  late GoRouter router;
  ProviderContainer? container;

  /// Ends the running "app", like closing it: nothing keeps queries open.
  Future<void> quit(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    container?.dispose();
    container = null;
  }

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  /// Starts the app the way `main.dart` does: the onboarding flag is read
  /// before the first frame.
  Future<void> launch(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final scope = container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        appVersionProvider.overrideWith((ref) async => '1.0.0 (1)'),
        clockProvider.overrideWithValue(FixedClock(DateTime(2026, 9, 30, 9))),
      ],
    );
    await pumpUntilDone(
      tester,
      scope.read(onboardingGateProvider.notifier).check(),
    );
    router = createAppRouter();
    addTearDown(router.dispose);
    // What app.dart does: finishing onboarding re-runs the redirect.
    scope.listen(onboardingGateProvider, (_, _) => router.refresh());
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: scope,
        child: MaterialApp.router(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> close(WidgetTester tester) async {
    await quit(tester);
    await pumpUntilDone(tester, db.close());
  }

  String location() => router.routerDelegate.currentConfiguration.uri.path;

  Future<void> tap(WidgetTester tester, String key) async {
    await tester.tap(find.byKey(ValueKey(key)));
    await tester.pumpAndSettle();
  }

  testWidgets('shown once: choices are saved, a restart goes to Home', (
    tester,
  ) async {
    await launch(tester);
    expect(location(), AppPaths.welcome);
    expect(find.text('Indonesian Rupiah (Rp)'), findsOneWidget);

    await tap(tester, 'onboarding-next');
    final gift = await pumpUntilDone(
      tester,
      (db.select(
        db.categories,
      )..where((c) => c.name.equals('Gift'))).getSingle(),
    );
    await tester.scrollUntilVisible(
      find.byKey(ValueKey('onboarding-category-${gift.id}')),
      200,
    );
    await tap(tester, 'onboarding-category-${gift.id}');

    await tap(tester, 'onboarding-next');
    for (final key in [
      KeypadKey.digit2,
      KeypadKey.digit5,
      KeypadKey.tripleZero,
    ]) {
      await tester.tap(find.byKey(ValueKey(key)));
      await tester.pump();
    }
    await tap(tester, 'onboarding-next');
    expect(location(), AppPaths.home);

    final cash = await pumpUntilDone(
      tester,
      db.select(db.accounts).getSingle(),
    );
    expect(cash.openingBalance, 25000);
    final names = await pumpUntilDone(
      tester,
      db.select(db.categories).map((c) => c.name).get(),
    );
    expect(names, isNot(contains('Gift')));

    // Next launch: straight to Home.
    await quit(tester);
    await launch(tester);
    expect(location(), AppPaths.home);
    await close(tester);
  });

  testWidgets('skip changes nothing and never shows it again', (tester) async {
    await launch(tester);
    await tap(tester, 'onboarding-skip');
    expect(location(), AppPaths.home);
    final categories = await pumpUntilDone(
      tester,
      db.select(db.categories).get(),
    );
    expect(categories, hasLength(14));

    await quit(tester);
    await launch(tester);
    expect(location(), AppPaths.home);
    await close(tester);
  });

  testWidgets('the last category of a type cannot be unticked', (tester) async {
    await launch(tester);
    await tap(tester, 'onboarding-next');
    final income = await pumpUntilDone(
      tester,
      (db.select(db.categories)..where((c) => c.type.equals('income'))).get(),
    );
    for (final c in income.skip(1)) {
      final finder = find.byKey(ValueKey('onboarding-category-${c.id}'));
      await tester.scrollUntilVisible(finder, 200);
      await tap(tester, 'onboarding-category-${c.id}');
    }
    final last = find.byKey(ValueKey('onboarding-category-${income.first.id}'));
    await tester.scrollUntilVisible(last, 200);
    expect(tester.widget<CheckboxListTile>(last).onChanged, isNull);
    await close(tester);
  });

  testWidgets('fits at 360 dp and 200% font', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await launch(tester);
    tester.view.physicalSize = const Size(360, 780);
    for (var page = 0; page < 3; page++) {
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'page $page');
      if (page < 2) await tap(tester, 'onboarding-next');
    }
    await close(tester);
  });
}
