import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/lock/data/datasources/device_security_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/lock_secure_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/pin_hasher.dart';
import 'package:expense_tracker/features/lock/data/repositories/lock_repository_impl.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:expense_tracker/features/lock/domain/usecases/manage_pin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBiometric implements BiometricDataSource {
  bool enrolled = true;
  bool accept = true;

  @override
  Future<bool> available() async => enrolled;

  @override
  Future<bool> authenticate(String reason) async => accept;
}

class FakeWindow implements SecureWindowDataSource {
  bool? secure;

  @override
  Future<void> setSecure({required bool secure}) async => this.secure = secure;
}

void main() {
  late Map<String, String> stored;
  late LockRepositoryImpl repo;
  final t0 = DateTime(2026, 9, 29, 12);

  LockRepositoryImpl newRepo() => LockRepositoryImpl(
    const LockSecureDataSource(FlutterSecureStorage()),
    const PinHasher(iterations: 1000, inBackground: false),
    FakeBiometric(),
    FakeWindow(),
  );

  setUp(() {
    stored = {};
    FlutterSecureStorage.setMockInitialValues(stored);
    repo = newRepo();
  });

  Future<LockSettings> settings() async =>
      (await repo.settings()).getOrElse((f) => fail('$f'));
  Future<UnlockResult> verify(String pin, DateTime at) async =>
      (await repo.verifyPin(pin, at)).getOrElse((f) => fail('$f'));

  test('off until a PIN is set', () async {
    expect(await settings(), const LockSettings());
  });

  test('setPin stores a salted hash and the length, never the PIN', () async {
    await repo.setPin('482913');
    expect(await settings(), const LockSettings(enabled: true, pinLength: 6));
    expect(stored.values.join(), isNot(contains('482913')));
    expect(stored.keys, containsAll(['lock.pin_hash', 'lock.pin_length']));
  });

  test('right and wrong PIN', () async {
    await repo.setPin('1234');
    expect(await verify('1234', t0), const UnlockResult.success());
    expect(await verify('4321', t0), const UnlockResult.wrongPin(triesLeft: 4));
  });

  test('five misses start a 30 s wait, even for the right PIN', () async {
    await repo.setPin('1234');
    for (var i = 1; i <= 4; i++) {
      expect(await verify('0000', t0), UnlockResult.wrongPin(triesLeft: 5 - i));
    }
    final retryAt = t0.add(const Duration(seconds: 30));
    expect(await verify('0000', t0), UnlockResult.throttled(retryAt: retryAt));
    expect(
      await verify('1234', t0.add(const Duration(seconds: 29))),
      UnlockResult.throttled(retryAt: retryAt),
      reason: 'not even checked during the wait',
    );
    // The wait survives an app restart.
    repo = newRepo();
    expect(
      await verify('1234', t0.add(const Duration(seconds: 10))),
      UnlockResult.throttled(retryAt: retryAt),
    );
    expect(await verify('1234', retryAt), const UnlockResult.success());
    expect(
      await verify('0000', retryAt),
      const UnlockResult.wrongPin(triesLeft: 4),
      reason: 'success resets the count',
    );
  });

  test('a miss after the wait waits again', () async {
    await repo.setPin('1234');
    for (var i = 0; i < 5; i++) {
      await verify('0000', t0);
    }
    final later = t0.add(const Duration(minutes: 1));
    expect(
      await verify('0000', later),
      UnlockResult.throttled(retryAt: later.add(const Duration(seconds: 30))),
    );
  });

  test('changing the PIN keeps other settings and clears misses', () async {
    await repo.setPin('1234');
    await repo.setTimeout(LockTimeout.minutes5);
    await repo.setBiometric(enabled: true);
    await verify('0000', t0);
    await repo.setPin('98765');
    expect(
      await settings(),
      const LockSettings(
        enabled: true,
        pinLength: 5,
        biometric: true,
        timeout: LockTimeout.minutes5,
      ),
    );
    expect(await verify('1234', t0), const UnlockResult.wrongPin(triesLeft: 4));
    expect(await verify('98765', t0), const UnlockResult.success());
  });

  test('disable forgets everything', () async {
    await repo.setPin('1234');
    await repo.setBiometric(enabled: true);
    await verify('0000', t0);
    await repo.disable();
    expect(stored, isEmpty);
    expect(await settings(), const LockSettings());
    expect(
      (await repo.verifyPin('1234', t0)).getLeft().toNullable(),
      isA<NotFoundFailure>(),
    );
  });

  test('an unknown stored timeout falls back to 1 minute', () async {
    await repo.setPin('1234');
    stored['lock.timeout'] = 'forever';
    expect((await settings()).timeout, LockTimeout.minute1);
  });

  test('SetPin rejects anything but 4–6 digits', () async {
    final setPin = SetPin(repo);
    for (final bad in ['123', '1234567', 'abcd']) {
      expect(
        (await setPin(bad)).getLeft().toNullable(),
        const Failure.validation(ValidationReason.pinInvalid),
      );
    }
    expect(stored, isEmpty);
  });
}
