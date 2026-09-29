import 'package:expense_tracker/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

extension EitherFailureX<T> on Either<Failure, T> {
  /// The value, or throws the [Failure] so a Notifier's `build` ends in
  /// `AsyncError(failure)`. Only for Notifier builds, never in domain/data.
  T getOrThrow() => fold((failure) => throw failure, (value) => value);

  Failure? get failureOrNull => fold((failure) => failure, (_) => null);
}

extension EitherStreamX<T> on Stream<Either<Failure, T>> {
  /// Values as events and failures as errors, for a StreamNotifier `build`.
  Stream<T> unwrap() => map((either) => either.getOrThrow());
}
