import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LockRepository {
  Future<Either<Failure, LockSettings>> settings();

  /// Stores a salted hash of [pin] (never the PIN) and turns the lock on.
  Future<Either<Failure, Unit>> setPin(String pin);

  /// Checks [pin] at [now], counting misses across app restarts.
  Future<Either<Failure, UnlockResult>> verifyPin(String pin, DateTime now);

  /// Removes the PIN and every lock setting.
  Future<Either<Failure, Unit>> disable();

  Future<Either<Failure, Unit>> setBiometric({required bool enabled});

  Future<Either<Failure, Unit>> setTimeout(LockTimeout timeout);

  /// The device has fingerprint/face enrolled.
  Future<Either<Failure, bool>> biometricAvailable();

  /// Shows the OS prompt with [reason]; Right(false) when cancelled.
  Future<Either<Failure, bool>> authenticateBiometric(String reason);

  /// Hides the app in the recents switcher and blocks screenshots.
  Future<Either<Failure, Unit>> setSecureWindow({required bool secure});
}
