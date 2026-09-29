import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/category_breakdown/presentation/widgets/category_breakdown_view.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:expense_tracker/features/reports/daily/presentation/widgets/daily_view.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/category_total.dart';
import 'package:expense_tracker/features/reports/trends/domain/entities/month_totals.dart';
import 'package:expense_tracker/features/reports/trends/presentation/widgets/trends_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// TalkBack text summaries for every chart (DESIGN §7.9).
void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  CategoryTotal total(String name, int amount) => CategoryTotal(
    category: Category(
      id: name,
      name: name,
      type: CategoryType.expense,
      icon: 'restaurant',
      color: PaletteColor.orange,
      isArchived: false,
      sortOrder: 0,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    ),
    amount: amount,
    count: 1,
  );

  test('category breakdown', () {
    final breakdown = CategoryBreakdown(
      type: CategoryType.expense,
      totals: [
        total('Food', 1840000),
        total('Transport', 790000),
        total('Other', 1750000),
      ],
    );
    expect(
      categoryBreakdownSummary(l10n, breakdown, 'September 2026'),
      'Spending by category, September 2026. '
      'Food 42 percent, 1 million 840 thousand rupiah. '
      'Transport 18 percent, 790 thousand rupiah. '
      'Other 40 percent, 1 million 750 thousand rupiah.',
    );
  });

  test('empty breakdown', () {
    expect(
      categoryBreakdownSummary(
        l10n,
        const CategoryBreakdown(type: CategoryType.income, totals: []),
        'September 2026',
      ),
      'Income by category, September 2026: no data.',
    );
  });

  test('trends', () {
    final months = [
      MonthTotals(
        period: Period.monthContaining(LocalDate(2026, 9, 1)),
        income: 8500000,
        expense: 6350000,
      ),
    ];
    expect(
      trendsSummary(l10n, months),
      'Income vs expense, last 1 months. Sep: income 8 million 500 thousand '
      'rupiah, expense 6 million 350 thousand rupiah, net 2 million 150 '
      'thousand rupiah.',
    );
  });

  test('daily', () {
    final daily = DailySpending(
      period: Period.monthContaining(LocalDate(2026, 9, 1)),
      today: LocalDate(2026, 9, 10),
      byDay: {LocalDate(2026, 9, 5): 1000000, LocalDate(2026, 9, 6): 60000},
    );
    expect(
      dailySummary(l10n, daily),
      'Daily spending, September 2026. Average 106 thousand rupiah. '
      'Highest 5 September, 1 million rupiah.',
    );
  });
}
