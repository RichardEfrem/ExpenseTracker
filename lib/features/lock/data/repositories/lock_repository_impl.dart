import 'dart:convert';

import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/lock/data/datasources/device_security_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/lock_secure_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/pin_hasher.dart';
import 'package:expense_tracker/features/lock/data/models/pin_hash_model.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/pin.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:expense_tracker/features/lock/domain/repositories/lock_repository.dart';
import 'package:fpdart/fpdart.dart';

typedef _Keys = LockSecureDataSource;

class LockRepositoryImpl implements LockRepository {
  const LockRepositoryImpl(
    this._store,
    this._hasher,
    this._biometric,
    this._window,
  );

  final LockSecureDataSource _store;
  final PinHasher _hasher;
  final BiometricDataSource _biometric;
  final SecureWindowDataSource _window;

  @override
  Future<Either<Failure, LockSettings>> settings() => guard(() async {
    final hash = await _store.read(_Keys.pinHash);
    if (hash == null) return const LockSettings();
    final timeout = await _store.read(_Keys.timeout);
    return LockSettings(
      enabled: true,
      pinLength: int.tryParse(await _store.read(_Keys.pinLength) ?? '') ?? 0,
      biometric: await _store.read(_Keys.biometric) == 'true',
      timeout: LockTimeout.values.asNameMap()[timeout] ?? LockTimeout.minute1,
    );
  });

  @override
  Future<Either<Failure, Unit>> setPin(String pin) => guard(() async {
    final hash = await _hasher.hash(pin);
    await _store.write(_Keys.pinHash, jsonEncode(hash.toJson()));
    await _store.write(_Keys.pinLength, '${pin.length}');
    await _store.delete(_Keys.failures);
    await _store.delete(_Keys.lastFailure);
    return unit;
  });

  @override
  Future<Either<Failure, UnlockResult>> verifyPin(
    String pin,
    DateTime now,
  ) => guard(() async {
    final failures = int.tryParse(await _store.read(_Keys.failures) ?? '') ?? 0;
    final lastMs = int.tryParse(await _store.read(_Keys.lastFailure) ?? '');
    final retryAt = PinThrottle.retryAt(
      failures,
      lastMs == null ? null : DateTime.fromMillisecondsSinceEpoch(lastMs),
    );
    if (retryAt != null && now.isBefore(retryAt)) {
      return UnlockResult.throttled(retryAt: retryAt);
    }
    final stored = await _store.read(_Keys.pinHash);
    if (stored == null) {
      throw const FailureException(Failure.notFound('no PIN set'));
    }
    final hash = PinHashModel.fromJson(
      jsonDecode(stored) as Map<String, dynamic>,
    );
    if (await _hasher.verify(pin, hash)) {
      await _store.delete(_Keys.failures);
      await _store.delete(_Keys.lastFailure);
      return const UnlockResult.success();
    }
    final missed = failures + 1;
    await _store.write(_Keys.failures, '$missed');
    await _store.write(_Keys.lastFailure, '${now.millisecondsSinceEpoch}');
    return switch (PinThrottle.retryAt(missed, now)) {
      final at? => UnlockResult.throttled(retryAt: at),
      null => UnlockResult.wrongPin(triesLeft: PinThrottle.triesLeft(missed)),
    };
  });

  @override
  Future<Either<Failure, Unit>> disable() => guard(() async {
    for (final key in _Keys.all) {
      await _store.delete(key);
    }
    return unit;
  });

  @override
  Future<Either<Failure, Unit>> setBiometric({required bool enabled}) =>
      guard(() async {
        await _store.write(_Keys.biometric, '$enabled');
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> setTimeout(LockTimeout timeout) =>
      guard(() async {
        await _store.write(_Keys.timeout, timeout.name);
        return unit;
      });

  @override
  Future<Either<Failure, bool>> biometricAvailable() =>
      guard(_biometric.available);

  @override
  Future<Either<Failure, bool>> authenticateBiometric(String reason) =>
      guard(() => _biometric.authenticate(reason));

  @override
  Future<Either<Failure, Unit>> setSecureWindow({required bool secure}) =>
      guard(() async {
        await _window.setSecure(secure: secure);
        return unit;
      });
}
