import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_statistics.freezed.dart';

@Freezed(copyWith: false)
abstract class LargestExpense with _$LargestExpense {
  const factory LargestExpense({
    required String transactionId,
    required int amount,
    required LocalDate date,
    Category? category,
  }) = _LargestExpense;
}

@Freezed(copyWith: false)
abstract class CategoryCount with _$CategoryCount {
  const factory CategoryCount({
    required Category category,
    required int count,
  }) = _CategoryCount;
}

/// The key statistics of a period (PRD §5.3). Raw sums come from SQL; the
/// derived figures are pure getters here.
@Freezed(copyWith: false)
abstract class PeriodStatistics with _$PeriodStatistics {
  const factory PeriodStatistics({
    required Period period,
    required LocalDate today,
    required int income,
    required int expense,
    required int previousIncome,
    required int previousExpense,

    /// Days up to today with at least one expense.
    required int expenseDays,
    LargestExpense? largestExpense,
    CategoryCount? mostFrequentCategory,
  }) = _PeriodStatistics;

  const PeriodStatistics._();

  int get net => income - expense;

  int get previousNet => previousIncome - previousExpense;

  bool get isEmpty => income == 0 && expense == 0;

  /// (Income − Expense) / Income; only when there is income.
  double? get savingsRate => income > 0 ? net / income : null;

  /// Days counted for averages: up to today in the current period.
  int get daysElapsed => period.daysElapsed(today);

  /// Expense / days elapsed, rounded half up; null before the period starts.
  int? get averageDailySpend =>
      daysElapsed == 0 ? null : _divide(expense, daysElapsed);

  /// Average daily spend × days in month; current month only.
  int? get projectedMonthEnd =>
      period.kind == PeriodKind.month &&
          period.isCurrent(today) &&
          daysElapsed > 0
      ? _divide(expense * period.lengthInDays, daysElapsed)
      : null;

  /// Elapsed days with zero expenses.
  int? get noSpendDays => daysElapsed == 0 ? null : daysElapsed - expenseDays;

  static int _divide(int a, int b) => (2 * a + b) ~/ (2 * b);
}
