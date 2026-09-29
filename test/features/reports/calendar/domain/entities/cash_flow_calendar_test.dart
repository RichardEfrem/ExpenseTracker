import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/calendar/domain/entities/cash_flow_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final today = LocalDate(2026, 9, 29);
  final sep = Period.monthContaining(LocalDate(2026, 9, 1));

  group('step thresholds (5 per direction, rounded up)', () {
    for (final (net, expected) in [
      (0, 0),
      (1, 1),
      (200, 1),
      (201, 2),
      (400, 2),
      (401, 3),
      (600, 3),
      (601, 4),
      (800, 4),
      (801, 5),
      (1000, 5),
      (-1, -1),
      (-100, -1),
      (-101, -2),
      (-250, -3),
      (-500, -5),
    ]) {
      test('$net → $expected', () {
        expect(CashFlowCalendar.step(net, maxIn: 1000, maxOut: 500), expected);
      });
    }
  });

  test('each direction scales to its own largest day', () {
    final calendar = CashFlowCalendar(
      period: sep,
      today: today,
      netByDay: {
        LocalDate(2026, 9, 1): 8500000,
        LocalDate(2026, 9, 5): -65000,
        LocalDate(2026, 9, 24): -300000,
      },
    );
    expect((calendar.maxIn, calendar.maxOut), (8500000, 300000));
    expect(calendar.stepOf(LocalDate(2026, 9, 1)), 5);
    expect(calendar.stepOf(LocalDate(2026, 9, 24)), -5);
    expect(calendar.stepOf(LocalDate(2026, 9, 5)), -2);
    expect(calendar.stepOf(LocalDate(2026, 9, 2)), 0, reason: 'no data');
  });

  group('blocks', () {
    CashFlowCalendar of(Period period) =>
        CashFlowCalendar(period: period, today: today, netByDay: const {});

    test('September 2026 from Monday: Tue 1st is the second cell', () {
      final blocks = of(sep).blocks(DateTime.monday);
      expect(blocks, hasLength(1));
      final cells = blocks.single.cells;
      expect(blocks.single.month, isNull);
      expect(cells.length % 7, 0);
      expect(cells.take(2).toList(), [null, LocalDate(2026, 9, 1)]);
      expect(cells.whereType<LocalDate>(), hasLength(30));
      expect(cells.length, 35);
    });

    test('Sunday week start shifts the lead', () {
      final cells = of(sep).blocks(DateTime.sunday).single.cells;
      expect(cells.take(3).toList(), [null, null, LocalDate(2026, 9, 1)]);
    });

    test('start day 25: one grid from 25 Aug to 24 Sep', () {
      final period = Period.monthContaining(
        LocalDate(2026, 9, 1),
        startDay: 25,
      );
      final cells = of(period).blocks(DateTime.monday).single.cells;
      final days = cells.whereType<LocalDate>().toList();
      expect(
        (days.first, days.last),
        (LocalDate(2026, 8, 25), LocalDate(2026, 9, 24)),
      );
      // 25 Aug 2026 is a Tuesday.
      expect(cells.take(2).toList(), [null, LocalDate(2026, 8, 25)]);
    });

    test('a week is one row', () {
      final week = Period.weekContaining(today);
      expect(of(week).blocks(DateTime.monday).single.cells, hasLength(7));
    });

    test('a year splits into 12 month blocks', () {
      final blocks = of(Period.yearContaining(today)).blocks(DateTime.monday);
      expect(blocks, hasLength(12));
      expect(blocks.first.month, LocalDate(2026, 1, 1));
      expect(blocks.last.month, LocalDate(2026, 12, 1));
      expect(
        blocks.fold(0, (n, b) => n + b.cells.whereType<LocalDate>().length),
        365,
      );
    });
  });
}
