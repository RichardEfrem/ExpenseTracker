import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';

extension OnboardingInputJson on OnboardingInput {
  /// Keys are snake_case; ids are sorted so the payload is stable. Both
  /// fields are always written.
  Map<String, Object?> toJson() => {
    'removed_category_ids': [...removedCategoryIds]..sort(),
    'opening_cash': openingCash,
  };
}
