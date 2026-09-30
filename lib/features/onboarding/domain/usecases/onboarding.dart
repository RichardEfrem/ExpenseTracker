import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';
import 'package:expense_tracker/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetOnboardingPending {
  const GetOnboardingPending(this._repository);

  final OnboardingRepository _repository;

  Future<Either<Failure, bool>> call() => _repository.isPending();
}

/// Finishes onboarding with the user's choices (DESIGN §8.12).
class CompleteOnboarding {
  const CompleteOnboarding(this._repository);

  final OnboardingRepository _repository;

  Future<Either<Failure, Unit>> call(OnboardingInput input) =>
      input.validate().match(
        (reason) async => Left(Failure.validation(reason)),
        _repository.complete,
      );
}

class SkipOnboarding {
  const SkipOnboarding(this._repository);

  final OnboardingRepository _repository;

  Future<Either<Failure, Unit>> call() => _repository.skip();
}
