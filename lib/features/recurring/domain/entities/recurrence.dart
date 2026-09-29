import 'package:expense_tracker/core/utils/local_date.dart';

enum RecurrenceFrequency { daily, weekly, monthly, yearly }

/// When a rule's occurrences fall (PRD REC-01, REC-04). Pure date math on
/// local dates, so there are no time-zone or DST surprises.
///
/// Monthly rules fall on [dayOfMonth] (default: the start's day); in
/// shorter months a day past the end falls on the last day (31 → 30 Apr,
/// 28/29 Feb). Yearly rules keep the start's month and day; 29 Feb falls on
/// 28 Feb in non-leap years.
final class RecurrenceSchedule {
  const RecurrenceSchedule({
    required this.frequency,
    required this.start,
    this.interval = 1,
    this.dayOfMonth,
    this.end,
  }) : assert(interval >= 1);

  final RecurrenceFrequency frequency;
  final int interval;
  final int? dayOfMonth;
  final LocalDate start;
  final LocalDate? end;

  /// The [n]th scheduled date (n ≥ 0), before the start/end filters.
  LocalDate _nth(int n) {
    final step = n * interval;
    switch (frequency) {
      case RecurrenceFrequency.daily:
        return start.addDays(step);
      case RecurrenceFrequency.weekly:
        return start.addDays(7 * step);
      case RecurrenceFrequency.monthly:
        final month = start.firstOfMonth.addMonths(step);
        final day = (dayOfMonth ?? start.day).clamp(1, month.daysInThisMonth);
        return LocalDate(month.year, month.month, day);
      case RecurrenceFrequency.yearly:
        final year = start.year + step;
        final day = start.day.clamp(
          1,
          LocalDate.daysInMonth(year, start.month),
        );
        return LocalDate(year, start.month, day);
    }
  }

  /// Occurrences after [after] (exclusive; null = from the start) up to
  /// [until] (inclusive), within start/end, in order.
  List<LocalDate> between(LocalDate? after, LocalDate until) {
    final last = end == null ? until : LocalDate.min(until, end!);
    final dates = <LocalDate>[];
    for (var n = 0; ; n++) {
      final date = _nth(n);
      if (date > last) break;
      if (date >= start && (after == null || date > after)) dates.add(date);
    }
    return dates;
  }

  /// The first occurrence on or after [date], or null when the schedule has
  /// ended.
  LocalDate? nextOnOrAfter(LocalDate date) {
    for (var n = 0; ; n++) {
      final candidate = _nth(n);
      if (end != null && candidate > end!) return null;
      if (candidate >= start && candidate >= date) return candidate;
    }
  }
}
