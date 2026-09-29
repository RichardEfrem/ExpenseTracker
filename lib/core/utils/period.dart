import 'package:expense_tracker/core/utils/local_date.dart';

enum PeriodKind { week, month, year, custom }

/// A date range for reports and lists, both ends inclusive.
///
/// Months honour a custom start day (PRD §4.6): with start day 25 the month
/// "September" runs 25 Aug – 24 Sep. A start day past the end of a short
/// month clamps to its last day (31 → 28 Feb), so periods stay contiguous.
final class Period {
  const Period._(
    this.kind,
    this.start,
    this.end, {
    this.monthStartDay = 1,
    this.firstWeekday = DateTime.monday,
  });

  /// The month period that contains [date].
  factory Period.monthContaining(LocalDate date, {int startDay = 1}) {
    _checkStartDay(startDay);
    final thisMonthStart = _monthStart(date.year, date.month, startDay);
    final anchor = date >= thisMonthStart
        ? thisMonthStart
        : _monthStart(
            date.addMonths(-1).year,
            date.addMonths(-1).month,
            startDay,
          );
    return Period.monthStartingIn(
      anchor.year,
      anchor.month,
      startDay: startDay,
    );
  }

  /// The month period that starts in [year]-[month].
  factory Period.monthStartingIn(int year, int month, {int startDay = 1}) {
    _checkStartDay(startDay);
    final start = _monthStart(year, month, startDay);
    final next = start.addMonths(1);
    final end = _monthStart(next.year, next.month, startDay).addDays(-1);
    return Period._(PeriodKind.month, start, end, monthStartDay: startDay);
  }

  /// The week containing [date]; [firstWeekday] is 1 (Mon) … 7 (Sun).
  factory Period.weekContaining(
    LocalDate date, {
    int firstWeekday = DateTime.monday,
  }) {
    RangeError.checkValueInInterval(firstWeekday, 1, 7, 'firstWeekday');
    final offset = (date.weekday - firstWeekday) % 7;
    final start = date.addDays(-offset);
    return Period._(
      PeriodKind.week,
      start,
      start.addDays(6),
      firstWeekday: firstWeekday,
    );
  }

  /// The calendar year containing [date].
  factory Period.yearContaining(LocalDate date) => Period._(
    PeriodKind.year,
    LocalDate(date.year, 1, 1),
    LocalDate(date.year, 12, 31),
  );

  /// Any inclusive range; [start] must not be after [end].
  factory Period.custom(LocalDate start, LocalDate end) {
    if (start > end) {
      throw ArgumentError('start $start is after end $end');
    }
    return Period._(PeriodKind.custom, start, end);
  }

  /// The [kind] period containing [date] (custom falls back to month).
  factory Period.of(
    PeriodKind kind,
    LocalDate date, {
    int monthStartDay = 1,
    int firstWeekday = DateTime.monday,
  }) => switch (kind) {
    PeriodKind.week => Period.weekContaining(date, firstWeekday: firstWeekday),
    PeriodKind.year => Period.yearContaining(date),
    PeriodKind.month ||
    PeriodKind.custom => Period.monthContaining(date, startDay: monthStartDay),
  };

  final PeriodKind kind;
  final LocalDate start;
  final LocalDate end;

  /// Only meaningful for [PeriodKind.month].
  final int monthStartDay;

  /// Only meaningful for [PeriodKind.week].
  final int firstWeekday;

  static LocalDate _monthStart(int year, int month, int startDay) => LocalDate(
    year,
    month,
    startDay.clamp(1, LocalDate.daysInMonth(year, month)),
  );

  static void _checkStartDay(int startDay) =>
      RangeError.checkValueInInterval(startDay, 1, 31, 'startDay');

  int get lengthInDays => start.daysUntil(end) + 1;

  /// True when this month period is a plain calendar month.
  bool get isCalendarMonth =>
      kind == PeriodKind.month && start.day == 1 && end == start.lastOfMonth;

  Period previous() => _shift(-1);

  Period next() => _shift(1);

  Period _shift(int steps) => switch (kind) {
    PeriodKind.week => Period._(
      kind,
      start.addDays(7 * steps),
      end.addDays(7 * steps),
      firstWeekday: firstWeekday,
    ),
    PeriodKind.month => () {
      final month = start.addMonths(steps);
      return Period.monthStartingIn(
        month.year,
        month.month,
        startDay: monthStartDay,
      );
    }(),
    PeriodKind.year => Period.yearContaining(
      LocalDate(start.year + steps, 1, 1),
    ),
    PeriodKind.custom => Period._(
      kind,
      start.addDays(lengthInDays * steps),
      end.addDays(lengthInDays * steps),
    ),
  };

  bool contains(LocalDate date) => date >= start && date <= end;

  bool isCurrent(LocalDate today) => contains(today);

  /// Starts after [today]: nothing can have happened in it yet.
  bool isFuture(LocalDate today) => start > today;

  /// Days of this period up to and including [today]: all of them for a
  /// past period, none for a future one (PRD §5.3 average daily spend).
  int daysElapsed(LocalDate today) {
    if (today < start) return 0;
    if (today > end) return lengthInDays;
    return start.daysUntil(today) + 1;
  }

  @override
  bool operator ==(Object other) =>
      other is Period &&
      other.kind == kind &&
      other.start == start &&
      other.end == end &&
      other.monthStartDay == monthStartDay &&
      other.firstWeekday == firstWeekday;

  @override
  int get hashCode =>
      Object.hash(kind, start, end, monthStartDay, firstWeekday);

  @override
  String toString() => 'Period(${kind.name}, $start – $end)';
}
