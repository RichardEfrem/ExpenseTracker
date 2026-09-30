import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_input.freezed.dart';

/// What the user chose during onboarding (DESIGN §8.12).
@freezed
abstract class OnboardingInput with _$OnboardingInput {
  const factory OnboardingInput({
    /// Default categories to remove. Unused ones are deleted; any already in
    /// use are archived instead.
    @Default(<String>{}) Set<String> removedCategoryIds,

    /// Opening balance of the Cash account, in rupiah.
    @Default(0) int openingCash,
  }) = _OnboardingInput;

  const OnboardingInput._();

  Either<ValidationReason, OnboardingInput> validate() {
    if (openingCash < 0) return const Left(ValidationReason.invalidInput);
    if (openingCash > TransactionInput.maxAmount) {
      return const Left(ValidationReason.amountTooLarge);
    }
    return Right(this);
  }
}
