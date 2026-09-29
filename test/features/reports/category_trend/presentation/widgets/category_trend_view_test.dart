import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:expense_tracker/features/reports/category_trend/presentation/widgets/category_trend_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  test('summary reads each picked line month by month', () {
    final food = Category(
      id: 'food',
      name: 'Food',
      type: CategoryType.expense,
      icon: 'restaurant',
      color: PaletteColor.orange,
      isArchived: false,
      sortOrder: 0,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );
    final trend = CategoryTrend.of(
      [
        Period.monthContaining(LocalDate(2026, 8, 1)),
        Period.monthContaining(LocalDate(2026, 9, 1)),
      ],
      [(0, food, 1000000), (1, food, 1250000)],
    );
    expect(
      categoryTrendSummary(l10n, trend, trend.series),
      'Category trend, last 2 months. '
      'Food: Aug 1 million rupiah, Sep 1 million 250 thousand rupiah.',
    );
  });
}
