import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/lock/domain/entities/pin.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:expense_tracker/features/lock/domain/repositories/lock_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Sets (or changes) the PIN and turns the lock on.
class SetPin {
  const SetPin(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, Unit>> call(String pin) async => Pin.isValid(pin)
      ? _repository.setPin(pin)
      : const Left(Failure.validation(ValidationReason.pinInvalid));
}

/// Checks a PIN try, with throttling after repeated misses.
class VerifyPin {
  const VerifyPin(this._repository, this._clock);

  final LockRepository _repository;
  final Clock _clock;

  Future<Either<Failure, UnlockResult>> call(String pin) =>
      _repository.verifyPin(pin, _clock.now());
}

/// Turns the lock off and forgets the PIN.
class DisableLock {
  const DisableLock(this._repository);

  final LockRepository _repository;

  Future<Either<Failure, Unit>> call() => _repository.disable();
}
