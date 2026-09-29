import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:intl/intl.dart';

/// Date formats (DESIGN §5). English only; relative labels such as "Today"
/// are localized strings chosen by the caller.
abstract final class AppDateFormat {
  static final _dayMonth = DateFormat('d MMM', 'en_US');
  static final _dayMonthYear = DateFormat('d MMM y', 'en_US');
  static final _weekdayDayMonth = DateFormat('EEE, d MMM', 'en_US');
  static final _monthYear = DateFormat('MMMM y', 'en_US');
  static final _monthShort = DateFormat('MMM', 'en_US');
  static final _dayMonthLong = DateFormat('d MMMM', 'en_US');
  static final _time = DateFormat('HH:mm', 'en_US');

  /// `25 Aug`.
  static String dayMonth(LocalDate date) => _dayMonth.format(date.toDateTime());

  /// `25 Aug 2026`.
  static String dayMonthYear(LocalDate date) =>
      _dayMonthYear.format(date.toDateTime());

  /// `Mon, 28 Sep`.
  static String weekdayDayMonth(LocalDate date) =>
      _weekdayDayMonth.format(date.toDateTime());

  /// `28 September` (screen-reader text).
  static String dayMonthLong(LocalDate date) =>
      _dayMonthLong.format(date.toDateTime());

  /// `September 2026`.
  static String monthYear(LocalDate date) =>
      _monthYear.format(date.toDateTime());

  /// `Sep`.
  static String monthShort(LocalDate date) =>
      _monthShort.format(date.toDateTime());

  /// `21:04`.
  static String time(DateTime dateTime) => _time.format(dateTime);

  /// `September 2026` for a calendar month, `25 Aug – 24 Sep` for a custom
  /// start day, `2026` for a year, ranges for weeks and custom periods.
  static String period(Period period) {
    final (start, end) = (period.start, period.end);
    return switch (period.kind) {
      PeriodKind.year => '${start.year}',
      PeriodKind.month when period.isCalendarMonth => monthYear(start),
      _ when start.year != end.year =>
        '${dayMonthYear(start)} – ${dayMonthYear(end)}',
      _ => '${dayMonth(start)} – ${dayMonth(end)}',
    };
  }
}
