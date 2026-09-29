import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:expense_tracker/features/reports/compare/presentation/widgets/compare_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));
  final food = Category(
    id: 'food',
    name: 'Food & Drinks',
    type: CategoryType.expense,
    icon: 'restaurant',
    color: PaletteColor.orange,
    isArchived: false,
    sortOrder: 0,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  );
  CategoryChange change(int current, int previous) =>
      CategoryChange(category: food, current: current, previous: previous);

  test('Δ uses an arrow and a sign', () {
    expect(deltaLabel(300000), '▲ +300K');
    expect(deltaLabel(-128000), '▼ −128K');
    expect(deltaLabel(0), '0');
  });

  test('Δ% or New', () {
    expect(deltaPercentLabel(l10n, change(1250000, 1000000)), '▲ 25,0%');
    expect(deltaPercentLabel(l10n, change(0, 400000)), '▼ 100,0%');
    expect(deltaPercentLabel(l10n, change(50000, 0)), 'New');
  });

  test('row labels read every column aloud', () {
    expect(
      compareRowLabel(l10n, 'Food & Drinks', change(1250000, 1000000)),
      'Food & Drinks: 1 million 250 thousand rupiah this period, '
      '1 million rupiah the period before. '
      'Change plus 250 thousand rupiah, up 25,0%.',
    );
    expect(
      compareRowLabel(l10n, 'Gift', change(50000, 0)),
      'Gift: 50 thousand rupiah this period, 0 rupiah the period before. '
      'Change plus 50 thousand rupiah, new this period.',
    );
    expect(
      compareRowLabel(l10n, 'Rent', change(100, 100)),
      'Rent: 100 rupiah this period, 100 rupiah the period before. '
      'Change 0 rupiah, unchanged.',
    );
  });
}
