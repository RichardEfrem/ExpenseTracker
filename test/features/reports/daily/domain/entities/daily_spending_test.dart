import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sep = Period.monthContaining(LocalDate(2026, 9, 1));

  test('every day of the period, zeros filled', () {
    final daily = DailySpending(
      period: sep,
      today: LocalDate(2026, 9, 10),
      byDay: {LocalDate(2026, 9, 5): 65000},
    );
    expect(daily.days, hasLength(30));
    expect(daily.days[4], (LocalDate(2026, 9, 5), 65000));
    expect(daily.days.first.$2, 0);
  });

  test('average over elapsed days, half up; none before the period', () {
    DailySpending at(LocalDate today) => DailySpending(
      period: sep,
      today: today,
      byDay: {LocalDate(2026, 9, 5): 65000, LocalDate(2026, 9, 6): 35005},
    );
    expect(at(LocalDate(2026, 9, 10)).average, 10001);
    expect(at(LocalDate(2026, 10, 3)).average, 3334);
    expect(at(LocalDate(2026, 8, 1)).average, isNull);
  });
}
