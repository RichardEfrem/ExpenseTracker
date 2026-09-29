import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/trends/domain/usecases/watch_trends.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('last N months up to the selected one, oldest first', () {
    final months = WatchTrends.monthsEnding(
      Period.monthContaining(LocalDate(2026, 2, 10)),
      6,
      1,
    );
    expect(months.map((p) => p.start), [
      LocalDate(2025, 9, 1),
      LocalDate(2025, 10, 1),
      LocalDate(2025, 11, 1),
      LocalDate(2025, 12, 1),
      LocalDate(2026, 1, 1),
      LocalDate(2026, 2, 1),
    ]);
  });

  test('custom start day and a week selection', () {
    final months = WatchTrends.monthsEnding(
      Period.weekContaining(LocalDate(2026, 9, 29)),
      2,
      25,
    );
    expect(months.map((p) => (p.start, p.end)), [
      (LocalDate(2026, 8, 25), LocalDate(2026, 9, 24)),
      (LocalDate(2026, 9, 25), LocalDate(2026, 10, 24)),
    ]);
  });
}
