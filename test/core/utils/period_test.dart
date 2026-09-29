import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:flutter_test/flutter_test.dart';

LocalDate d(int y, int m, int day) => LocalDate(y, m, day);

void expectRange(Period p, LocalDate start, LocalDate end) {
  expect((p.start, p.end), (start, end), reason: '$p');
}

void main() {
  group('month, start day 1', () {
    test('calendar month', () {
      final p = Period.monthContaining(d(2026, 9, 15));
      expectRange(p, d(2026, 9, 1), d(2026, 9, 30));
      expect(p.isCalendarMonth, isTrue);
      expect(p.lengthInDays, 30);
    });
    test('February, non-leap and leap', () {
      expectRange(
        Period.monthContaining(d(2026, 2, 10)),
        d(2026, 2, 1),
        d(2026, 2, 28),
      );
      expectRange(
        Period.monthContaining(d(2024, 2, 10)),
        d(2024, 2, 1),
        d(2024, 2, 29),
      );
    });
  });

  group('month, start day 25', () {
    test('before the start day belongs to the previous start', () {
      final p = Period.monthContaining(d(2026, 9, 10), startDay: 25);
      expectRange(p, d(2026, 8, 25), d(2026, 9, 24));
      expect(p.isCalendarMonth, isFalse);
    });
    test('on the start day begins a new period', () {
      expectRange(
        Period.monthContaining(d(2026, 9, 25), startDay: 25),
        d(2026, 9, 25),
        d(2026, 10, 24),
      );
    });
    test('steps across the year boundary', () {
      final dec = Period.monthContaining(d(2026, 12, 30), startDay: 25);
      expectRange(dec, d(2026, 12, 25), d(2027, 1, 24));
      expectRange(dec.next(), d(2027, 1, 25), d(2027, 2, 24));
      expectRange(dec.previous(), d(2026, 11, 25), d(2026, 12, 24));
    });
  });

  group('month, start day 31 clamps in short months', () {
    test('January period ends before the clamped February start', () {
      expectRange(
        Period.monthContaining(d(2026, 2, 15), startDay: 31),
        d(2026, 1, 31),
        d(2026, 2, 27),
      );
    });
    test('February starts on its last day (non-leap and leap)', () {
      expectRange(
        Period.monthContaining(d(2026, 2, 28), startDay: 31),
        d(2026, 2, 28),
        d(2026, 3, 30),
      );
      expectRange(
        Period.monthContaining(d(2024, 2, 29), startDay: 31),
        d(2024, 2, 29),
        d(2024, 3, 30),
      );
      expectRange(
        Period.monthContaining(d(2024, 2, 28), startDay: 31),
        d(2024, 1, 31),
        d(2024, 2, 28),
      );
    });
    test('consecutive periods are contiguous for a whole year', () {
      var p = Period.monthStartingIn(2026, 1, startDay: 31);
      for (var i = 0; i < 12; i++) {
        final next = p.next();
        expect(next.start, p.end.addDays(1), reason: '$p → $next');
        p = next;
      }
    });
  });

  group('week', () {
    test('Monday start', () {
      expectRange(
        Period.weekContaining(d(2026, 9, 27)),
        d(2026, 9, 21),
        d(2026, 9, 27),
      );
      expectRange(
        Period.weekContaining(d(2026, 9, 28)),
        d(2026, 9, 28),
        d(2026, 10, 4),
      );
    });
    test('Sunday start', () {
      expectRange(
        Period.weekContaining(d(2026, 9, 28), firstWeekday: DateTime.sunday),
        d(2026, 9, 27),
        d(2026, 10, 3),
      );
    });
    test('steps across the year boundary', () {
      final p = Period.weekContaining(d(2026, 12, 31));
      expectRange(p, d(2026, 12, 28), d(2027, 1, 3));
      expectRange(p.next(), d(2027, 1, 4), d(2027, 1, 10));
      expect(p.next().previous(), p);
    });
  });

  test('year steps', () {
    final p = Period.yearContaining(d(2026, 9, 29));
    expectRange(p, d(2026, 1, 1), d(2026, 12, 31));
    expectRange(p.previous(), d(2025, 1, 1), d(2025, 12, 31));
    expect(Period.yearContaining(d(2024, 3, 1)).lengthInDays, 366);
  });

  test('custom steps by its own length', () {
    final p = Period.custom(d(2026, 9, 10), d(2026, 9, 19));
    expectRange(p.previous(), d(2026, 8, 31), d(2026, 9, 9));
    expectRange(p.next(), d(2026, 9, 20), d(2026, 9, 29));
    expect(
      () => Period.custom(d(2026, 9, 2), d(2026, 9, 1)),
      throwsArgumentError,
    );
  });

  group('daysElapsed, contains, isFuture', () {
    final sep = Period.monthContaining(d(2026, 9, 1));
    test('current period counts days up to today', () {
      expect(sep.daysElapsed(d(2026, 9, 1)), 1);
      expect(sep.daysElapsed(d(2026, 9, 29)), 29);
    });
    test('past period counts all days, future none', () {
      expect(sep.daysElapsed(d(2026, 10, 5)), 30);
      expect(sep.daysElapsed(d(2026, 8, 31)), 0);
    });
    test('contains is inclusive at both ends', () {
      expect(sep.contains(d(2026, 9, 1)), isTrue);
      expect(sep.contains(d(2026, 9, 30)), isTrue);
      expect(sep.contains(d(2026, 10, 1)), isFalse);
    });
    test('isFuture', () {
      expect(sep.next().isFuture(d(2026, 9, 29)), isTrue);
      expect(sep.isFuture(d(2026, 9, 29)), isFalse);
      expect(sep.isCurrent(d(2026, 9, 29)), isTrue);
    });
  });

  test('rejects start days outside 1–31', () {
    expect(
      () => Period.monthContaining(d(2026, 1, 1), startDay: 0),
      throwsRangeError,
    );
    expect(
      () => Period.monthContaining(d(2026, 1, 1), startDay: 32),
      throwsRangeError,
    );
  });
}
