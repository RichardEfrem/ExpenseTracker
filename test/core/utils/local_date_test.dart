import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ISO round-trip', () {
    expect(LocalDate(2026, 9, 5).toIso(), '2026-09-05');
    expect(LocalDate.parse('2026-09-05'), LocalDate(2026, 9, 5));
  });

  test('parse rejects malformed and impossible dates', () {
    for (final bad in [
      '2026-9-5',
      '2026-02-30',
      '2026-13-01',
      'x',
      '2026-09-05T00:00',
    ]) {
      expect(() => LocalDate.parse(bad), throwsFormatException, reason: bad);
    }
    expect(LocalDate.tryParse('2025-02-29'), isNull);
    expect(LocalDate.tryParse('2024-02-29'), LocalDate(2024, 2, 29));
  });

  test('constructor normalizes overflow', () {
    expect(LocalDate(2026, 2, 30), LocalDate(2026, 3, 2));
    expect(LocalDate(2026, 13, 1), LocalDate(2027, 1, 1));
  });

  test('addDays across month, year and DST-sensitive dates', () {
    expect(LocalDate(2026, 12, 31).addDays(1), LocalDate(2027, 1, 1));
    expect(LocalDate(2026, 3, 1).addDays(-1), LocalDate(2026, 2, 28));
    expect(LocalDate(2026, 3, 29).addDays(1), LocalDate(2026, 3, 30));
  });

  test('addMonths clamps to the last day', () {
    expect(LocalDate(2026, 1, 31).addMonths(1), LocalDate(2026, 2, 28));
    expect(LocalDate(2024, 1, 31).addMonths(1), LocalDate(2024, 2, 29));
    expect(LocalDate(2026, 1, 15).addMonths(-1), LocalDate(2025, 12, 15));
    expect(LocalDate(2026, 3, 31).addMonths(-13), LocalDate(2025, 2, 28));
  });

  test('daysUntil, weekday, ordering', () {
    expect(LocalDate(2026, 9, 1).daysUntil(LocalDate(2026, 9, 30)), 29);
    expect(LocalDate(2026, 9, 28).weekday, DateTime.monday);
    expect(LocalDate(2026, 9, 1) < LocalDate(2026, 9, 2), isTrue);
    expect(
      LocalDate.max(LocalDate(2026, 1, 1), LocalDate(2025, 1, 1)),
      LocalDate(2026, 1, 1),
    );
  });

  test('today uses the injected clock', () {
    expect(
      LocalDate.today(FixedClock(DateTime(2026, 9, 29, 23, 59))),
      LocalDate(2026, 9, 29),
    );
  });
}
