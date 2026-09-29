import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/repositories/lock_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLockSettings {
  const GetLockSettings(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, LockSettings>> call() => _repository.settings();
}

class SetLockTimeout {
  const SetLockTimeout(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, Unit>> call(LockTimeout timeout) =>
      _repository.setTimeout(timeout);
}

class SetBiometricUnlock {
  const SetBiometricUnlock(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, Unit>> call({required bool enabled}) =>
      _repository.setBiometric(enabled: enabled);
}

/// Keeps the window secure (FLAG_SECURE) exactly while the lock is on.
class ApplySecureWindow {
  const ApplySecureWindow(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, Unit>> call({required bool lockEnabled}) =>
      _repository.setSecureWindow(secure: lockEnabled);
}
