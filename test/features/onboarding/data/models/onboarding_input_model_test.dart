import 'package:expense_tracker/features/onboarding/data/models/onboarding_input_model.dart';
import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('payload: both fields always written, ids sorted', () {
    expect(
      const OnboardingInput(
        removedCategoryIds: {'b', 'a'},
        openingCash: 250000,
      ).toJson(),
      {
        'removed_category_ids': ['a', 'b'],
        'opening_cash': 250000,
      },
    );
  });

  test('defaults: nothing removed, zero cash (never omitted)', () {
    expect(const OnboardingInput().toJson(), {
      'removed_category_ids': <String>[],
      'opening_cash': 0,
    });
  });
}
