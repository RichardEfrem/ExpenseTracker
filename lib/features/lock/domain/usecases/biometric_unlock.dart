import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/lock/domain/repositories/lock_repository.dart';
import 'package:fpdart/fpdart.dart';

class CheckBiometricAvailable {
  const CheckBiometricAvailable(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, bool>> call() => _repository.biometricAvailable();
}

/// Unlocks via the OS biometric prompt; Right(false) when cancelled.
class AuthenticateBiometric {
  const AuthenticateBiometric(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, bool>> call(String reason) =>
      _repository.authenticateBiometric(reason);
}
