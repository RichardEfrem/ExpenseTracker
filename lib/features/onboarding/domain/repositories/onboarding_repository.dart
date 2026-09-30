import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class OnboardingRepository {
  /// True on a fresh install until onboarding is finished or skipped.
  Future<Either<Failure, bool>> isPending();

  /// Applies [input] and marks onboarding done, in one DB transaction.
  /// Fails with [ValidationReason.categoryRequired] if it would leave no
  /// active expense or income category.
  Future<Either<Failure, Unit>> complete(OnboardingInput input);

  /// Marks onboarding done without changing anything else.
  Future<Either<Failure, Unit>> skip();
}
