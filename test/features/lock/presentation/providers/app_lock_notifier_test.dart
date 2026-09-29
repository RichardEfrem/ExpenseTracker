import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/lock/data/datasources/device_security_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/pin_hasher.dart';
import 'package:expense_tracker/features/lock/data/lock_providers.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:expense_tracker/features/lock/presentation/providers/pin_entry_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBiometric implements BiometricDataSource {
  bool accept = true;
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
  final calls = <bool>[];

  @override
  Future<void> setSecure({required bool secure}) async => calls.add(secure);
}

void main() {
  late FixedClock clock;
  late FakeBiometric biometric;
  late FakeWindow window;
  late ProviderContainer container;

  const hasher = PinHasher(iterations: 1000, inBackground: false);

  /// A container over [stored] secure storage (a PIN when [pin] is set).
  Future<void> start({String? pin, Map<String, String>? extra}) async {
    final stored = <String, String>{};
    FlutterSecureStorage.setMockInitialValues(stored);
    clock = FixedClock(DateTime(2026, 9, 29, 12));
    biometric = FakeBiometric();
    window = FakeWindow();
    ProviderContainer make() => ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(clock),
        pinHasherProvider.overrideWithValue(hasher),
        biometricDataSourceProvider.overrideWithValue(biometric),
        secureWindowDataSourceProvider.overrideWithValue(window),
      ],
    );
    if (pin != null) {
      final setup = make();
      await setup.read(lockRepositoryProvider).setPin(pin);
      setup.dispose();
      stored.addAll(extra ?? {});
    }
    container = make();
    addTearDown(container.dispose);
    await container.read(appLockProvider.future);
  }

  AppLockState lock() => container.read(appLockProvider).requireValue;
  AppLockNotifier notifier() => container.read(appLockProvider.notifier);

  test('no PIN: unlocked, window left alone', () async {
    await start();
    expect(lock().status, LockStatus.unlocked);
    expect(window.calls, isEmpty);
  });

  test('a PIN: locked at start, window secure', () async {
    await start(pin: '1234');
    expect(lock().status, LockStatus.locked);
    expect(lock().settings.pinLength, 4);
    expect(window.calls, [true]);
  });

  test('wrong PIN stays locked; right PIN unlocks', () async {
    await start(pin: '1234');
    expect(
      (await notifier().unlockWithPin('9999')).toNullable(),
      const UnlockResult.wrongPin(triesLeft: 4),
    );
    expect(lock().status, LockStatus.locked);
    await notifier().unlockWithPin('1234');
    expect(lock().status, LockStatus.unlocked);
  });

  group('lock on resume after the timeout (fake clock)', () {
    Future<void> awayFor(Duration away) async {
      notifier().onHidden();
      clock.current = clock.current.add(away);
      notifier().onResumed();
    }

    test('1 minute: 59 s away stays open, 60 s locks', () async {
      await start(pin: '1234');
      await notifier().unlockWithPin('1234');
      await awayFor(const Duration(seconds: 59));
      expect(lock().status, LockStatus.unlocked);
      await awayFor(const Duration(seconds: 60));
      expect(lock().status, LockStatus.locked);
    });

    test('immediately: any trip away locks', () async {
      await start(pin: '1234', extra: {'lock.timeout': 'immediately'});
      await notifier().unlockWithPin('1234');
      await awayFor(Duration.zero);
      expect(lock().status, LockStatus.locked);
    });

    test(
      'a resume without hiding (e.g. a system dialog) never locks',
      () async {
        await start(pin: '1234', extra: {'lock.timeout': 'immediately'});
        await notifier().unlockWithPin('1234');
        notifier().onResumed();
        expect(lock().status, LockStatus.unlocked);
      },
    );

    test('the timeout counts from the last time it was hidden', () async {
      await start(pin: '1234');
      await notifier().unlockWithPin('1234');
      await awayFor(const Duration(seconds: 50));
      await awayFor(const Duration(seconds: 50));
      expect(lock().status, LockStatus.unlocked);
    });

    test('no lock without a PIN, however long away', () async {
      await start();
      await awayFor(const Duration(days: 2));
      expect(lock().status, LockStatus.unlocked);
    });
  });

  group('biometric', () {
    test('ignored while off', () async {
      await start(pin: '1234');
      expect(await notifier().unlockWithBiometric('why'), isFalse);
      expect(biometric.prompts, 0);
      expect(lock().status, LockStatus.locked);
    });

    test('unlocks when the OS confirms; cancelling stays locked', () async {
      await start(pin: '1234', extra: {'lock.biometric': 'true'});
      biometric.accept = false;
      expect(await notifier().unlockWithBiometric('why'), isFalse);
      expect(lock().status, LockStatus.locked);
      biometric.accept = true;
      expect(await notifier().unlockWithBiometric('why'), isTrue);
      expect(lock().status, LockStatus.unlocked);
    });
  });

  test('turning the lock on and off toggles the secure window', () async {
    await start();
    expect(await notifier().setPin('5678'), isNull);
    expect(
      lock(),
      const AppLockState(
        settings: LockSettings(enabled: true, pinLength: 4),
        status: LockStatus.unlocked,
      ),
    );
    expect(await notifier().setTimeout(LockTimeout.seconds30), isNull);
    expect(lock().settings.timeout, LockTimeout.seconds30);
    expect(await notifier().disable(), isNull);
    expect(lock().settings, const LockSettings());
    expect(window.calls, [true, false]);
  });

  group('lock screen entry', () {
    Future<void> type(String digits) async {
      for (final d in digits.split('')) {
        await container
            .read(lockScreenProvider.notifier)
            .onKey(KeypadKey.digit(int.parse(d)));
      }
    }

    test('checks by itself at the PIN length', () async {
      await start(pin: '1234');
      container.listen(lockScreenProvider, (_, _) {});
      await type('123');
      expect(container.read(lockScreenProvider).digits, '123');
      expect(lock().status, LockStatus.locked);
      await type('4');
      expect(lock().status, LockStatus.unlocked);
    });

    test(
      'a wrong PIN clears the dots and says so; keys wait out a throttle',
      () async {
        await start(pin: '1234');
        container.listen(lockScreenProvider, (_, _) {});
        await type('0000');
        expect(
          container.read(lockScreenProvider),
          const LockScreenState(rejected: UnlockResult.wrongPin(triesLeft: 4)),
        );
        await type('0000000000000000');
        expect(container.read(lockScreenProvider).waiting, isTrue);
        await type('1234');
        expect(container.read(lockScreenProvider).digits, '');
        expect(lock().status, LockStatus.locked);
      },
    );
  });

  group('PIN setup', () {
    PinSetupNotifier setup(PinSetupMode mode) =>
        container.read(pinSetupProvider(mode).notifier);
    PinSetupState state(PinSetupMode mode) =>
        container.read(pinSetupProvider(mode));
    Future<void> type(PinSetupMode mode, String digits) async {
      for (final d in digits.split('')) {
        await setup(mode).onKey(KeypadKey.digit(int.parse(d)));
      }
    }

    test('enable: choose, continue from 4 digits, confirm', () async {
      await start();
      const mode = PinSetupMode.enable;
      container.listen(pinSetupProvider(mode), (_, _) {});
      expect(state(mode).step, PinSetupStep.choose);
      await type(mode, '123');
      expect(state(mode).canContinue, isFalse);
      await type(mode, '4567');
      expect(state(mode).digits, '123456', reason: 'at most 6');
      setup(mode).submitChosen();
      expect(state(mode).step, PinSetupStep.confirm);
      await type(mode, '123456');
      expect(state(mode).step, PinSetupStep.done);
      expect(lock().settings, const LockSettings(enabled: true, pinLength: 6));
    });

    test('enable: a different confirmation starts over', () async {
      await start();
      const mode = PinSetupMode.enable;
      container.listen(pinSetupProvider(mode), (_, _) {});
      await type(mode, '1234');
      setup(mode).submitChosen();
      await type(mode, '1243');
      expect(
        state(mode),
        const PinSetupState(step: PinSetupStep.choose, mismatch: true),
      );
      expect(lock().settings.enabled, isFalse);
    });

    test('change: the current PIN first', () async {
      await start(pin: '1234');
      await notifier().unlockWithPin('1234');
      const mode = PinSetupMode.change;
      container.listen(pinSetupProvider(mode), (_, _) {});
      expect(state(mode).step, PinSetupStep.current);
      await type(mode, '9999');
      expect(state(mode).rejected, const UnlockResult.wrongPin(triesLeft: 4));
      expect(state(mode).step, PinSetupStep.current);
      await type(mode, '1234');
      expect(state(mode).step, PinSetupStep.choose);
      await type(mode, '24680');
      setup(mode).submitChosen();
      await type(mode, '24680');
      expect(state(mode).step, PinSetupStep.done);
      expect(
        (await notifier().checkPin('24680')).toNullable(),
        const UnlockResult.success(),
      );
    });

    test('disable: the current PIN turns it off', () async {
      await start(pin: '1234');
      await notifier().unlockWithPin('1234');
      const mode = PinSetupMode.disable;
      container.listen(pinSetupProvider(mode), (_, _) {});
      await type(mode, '1234');
      expect(state(mode).step, PinSetupStep.done);
      expect(lock().settings.enabled, isFalse);
      expect(window.calls.last, isFalse);
    });
  });

  group('redirect', () {
    Uri u(String s) => Uri.parse(s);
    test('locked: everything goes to the lock screen, remembering where', () {
      expect(lockRedirect(LockStatus.locked, u('/')), '/lock?from=%2F');
      expect(
        lockRedirect(LockStatus.locked, u('/activity?type=expense')),
        '/lock?from=%2Factivity%3Ftype%3Dexpense',
      );
      expect(lockRedirect(LockStatus.locked, u('/lock?from=%2F')), isNull);
    });
    test('unlocked: the lock screen returns where it came from', () {
      expect(
        lockRedirect(
          LockStatus.unlocked,
          u('/lock?from=%2Factivity%3Ftype%3Dexpense'),
        ),
        '/activity?type=expense',
      );
      expect(lockRedirect(LockStatus.unlocked, u('/lock')), '/');
      expect(
        lockRedirect(LockStatus.unlocked, u('/lock?from=https%3A%2F%2Fx.io')),
        '/',
        reason: 'only in-app paths',
      );
      expect(lockRedirect(LockStatus.unlocked, u('/reports')), isNull);
    });
    test('while loading nothing moves', () {
      expect(lockRedirect(null, u('/')), isNull);
    });
  });
}
