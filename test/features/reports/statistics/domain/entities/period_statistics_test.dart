import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/statistics/domain/entities/period_statistics.dart';
import 'package:flutter_test/flutter_test.dart';

PeriodStatistics stats({
  Period? period,
  LocalDate? today,
  int income = 0,
  int expense = 0,
  int expenseDays = 0,
}) => PeriodStatistics(
  period: period ?? Period.monthContaining(LocalDate(2026, 9, 1)),
  today: today ?? LocalDate(2026, 9, 10),
  income: income,
  expense: expense,
  previousIncome: 0,
  previousExpense: 0,
  expenseDays: expenseDays,
);

void main() {
  test('net and savings rate', () {
    final s = stats(income: 8000000, expense: 6000000);
    expect(s.net, 2000000);
    expect(s.savingsRate, 0.25);
  });

  test('no income → no savings rate', () {
    expect(stats(expense: 1000).savingsRate, isNull);
    expect(stats(income: 1000, expense: 3000).savingsRate, -2);
  });

  test('current period averages over days elapsed, half up', () {
    final s = stats(expense: 1000005, today: LocalDate(2026, 9, 10));
    expect(s.daysElapsed, 10);
    expect(s.averageDailySpend, 100001);
  });

  test('first day of the month counts one day', () {
    final s = stats(
      expense: 50000,
      today: LocalDate(2026, 9, 1),
      expenseDays: 1,
    );
    expect(s.averageDailySpend, 50000);
    expect(s.projectedMonthEnd, 1500000);
    expect(s.noSpendDays, 0);
  });

  test('past period averages over all its days and has no projection', () {
    final s = stats(expense: 300000, today: LocalDate(2026, 10, 15));
    expect(s.daysElapsed, 30);
    expect(s.averageDailySpend, 10000);
    expect(s.projectedMonthEnd, isNull);
  });

  test('projection only for a current month, not a week or year', () {
    expect(stats(expense: 100000).projectedMonthEnd, 300000);
    final week = Period.weekContaining(LocalDate(2026, 9, 10));
    expect(stats(period: week, expense: 100000).projectedMonthEnd, isNull);
    final year = Period.yearContaining(LocalDate(2026, 9, 10));
    expect(stats(period: year, expense: 100000).projectedMonthEnd, isNull);
  });

  test('future period has no averages', () {
    final s = stats(today: LocalDate(2026, 8, 31));
    expect(s.daysElapsed, 0);
    expect(s.averageDailySpend, isNull);
    expect(s.noSpendDays, isNull);
  });

  test('no-spend days = elapsed days without expenses', () {
    expect(stats(expenseDays: 4, today: LocalDate(2026, 9, 10)).noSpendDays, 6);
  });

  test('empty', () {
    expect(stats().isEmpty, isTrue);
    expect(stats(income: 1).isEmpty, isFalse);
  });
}
