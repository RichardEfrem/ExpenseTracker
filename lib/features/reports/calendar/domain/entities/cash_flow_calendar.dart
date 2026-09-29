import 'dart:math' as math;

import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cash_flow_calendar.freezed.dart';

/// Week rows of one calendar block. [cells] has a multiple of 7 entries;
/// null pads days outside the period.
@Freezed(copyWith: false)
abstract class CalendarBlock with _$CalendarBlock {
  const factory CalendarBlock({
    /// The calendar month when a long period is split per month; null for
    /// a single block.
    LocalDate? month,
    required List<LocalDate?> cells,
  }) = _CalendarBlock;
}

/// Daily net over a period, as a heat-map calendar (PRD RPT-06).
@Freezed(copyWith: false)
abstract class CashFlowCalendar with _$CashFlowCalendar {
  const factory CashFlowCalendar({
    required Period period,
    required LocalDate today,

    /// Income − expense for each day with any; other days are absent.
    required Map<LocalDate, int> netByDay,
  }) = _CashFlowCalendar;

  const CashFlowCalendar._();

  /// Tint steps per direction (DESIGN §8.5: 5 green, 5 red).
  static const steps = 5;

  /// Periods up to six weeks show as one grid; longer ones per month.
  static const maxSingleBlockDays = 42;

  int get maxIn => netByDay.values.fold(0, math.max);

  int get maxOut => -netByDay.values.fold(0, math.min);

  /// −5 … 5 for a day's [net]: its share of the largest net in the same
  /// direction, in fifths rounded up (so any non-zero day shows). 0 for a
  /// zero net.
  static int step(int net, {required int maxIn, required int maxOut}) {
    if (net == 0) return 0;
    final max = net > 0 ? maxIn : maxOut;
    final fifths = (net.abs() * steps + max - 1) ~/ max;
    return net.sign * fifths.clamp(1, steps);
  }

  /// The step of [day]; 0 when nothing was recorded.
  int stepOf(LocalDate day) => switch (netByDay[day]) {
    null => 0,
    final net => step(net, maxIn: maxIn, maxOut: maxOut),
  };

  /// The period as week rows starting on [firstWeekday] (1 = Monday).
  List<CalendarBlock> blocks(int firstWeekday) {
    CalendarBlock block(LocalDate from, LocalDate to, {LocalDate? month}) {
      final lead = (from.weekday - firstWeekday) % 7;
      final days = from.daysUntil(to) + 1;
      final cells = <LocalDate?>[
        for (var i = 0; i < lead; i++) null,
        for (var i = 0; i < days; i++) from.addDays(i),
      ];
      while (cells.length % 7 != 0) {
        cells.add(null);
      }
      return CalendarBlock(month: month, cells: cells);
    }

    if (period.lengthInDays <= maxSingleBlockDays) {
      return [block(period.start, period.end)];
    }
    return [
      for (
        var month = period.start.firstOfMonth;
        month <= period.end;
        month = month.addMonths(1)
      )
        block(
          LocalDate.max(month, period.start),
          LocalDate.min(month.lastOfMonth, period.end),
          month: month,
        ),
    ];
  }
}
