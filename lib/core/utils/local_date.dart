import 'package:expense_tracker/core/utils/clock.dart';

/// A calendar date with no time or zone, stored as `YYYY-MM-DD` (PRD §6.1),
/// so a late-night entry never jumps to another day.
final class LocalDate implements Comparable<LocalDate> {
  /// Normalizes overflowing parts, like [DateTime]: `(2026, 2, 30)` is
  /// 2 March.
  factory LocalDate(int year, int month, int day) =>
      LocalDate._fromUtc(DateTime.utc(year, month, day));

  const LocalDate._(this.year, this.month, this.day);

  factory LocalDate._fromUtc(DateTime utc) =>
      LocalDate._(utc.year, utc.month, utc.day);

  /// The date part of [dateTime] as the user sees it.
  factory LocalDate.fromDateTime(DateTime dateTime) =>
      LocalDate._(dateTime.year, dateTime.month, dateTime.day);

  factory LocalDate.today(Clock clock) => LocalDate.fromDateTime(clock.now());

  /// Parses strict `YYYY-MM-DD`; throws [FormatException] otherwise.
  factory LocalDate.parse(String iso) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(iso);
    if (match == null) throw FormatException('Not a YYYY-MM-DD date', iso);
    final (y, m, d) = (
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
    if (m < 1 || m > 12 || d < 1 || d > daysInMonth(y, m)) {
      throw FormatException('Invalid calendar date', iso);
    }
    return LocalDate._(y, m, d);
  }

  static LocalDate? tryParse(String iso) {
    try {
      return LocalDate.parse(iso);
    } on FormatException {
      return null;
    }
  }

  final int year;
  final int month;
  final int day;

  static int daysInMonth(int year, int month) =>
      DateTime.utc(year, month + 1, 0).day;

  DateTime get _utc => DateTime.utc(year, month, day);

  /// 1 = Monday … 7 = Sunday.
  int get weekday => _utc.weekday;

  int get daysInThisMonth => daysInMonth(year, month);

  LocalDate get firstOfMonth => LocalDate._(year, month, 1);

  LocalDate get lastOfMonth => LocalDate._(year, month, daysInThisMonth);

  LocalDate addDays(int days) =>
      LocalDate._fromUtc(_utc.add(Duration(days: days)));

  /// Same day [months] later, clamped to the target month's last day
  /// (31 Jan + 1 month = 28/29 Feb).
  LocalDate addMonths(int months) {
    final index = year * 12 + (month - 1) + months;
    final y = index ~/ 12;
    final m = index % 12 + 1;
    final d = day.clamp(1, daysInMonth(y, m));
    return LocalDate._(y, m, d);
  }

  /// Whole days from this date to [other] (negative if [other] is earlier).
  int daysUntil(LocalDate other) => other._utc.difference(_utc).inDays;

  /// Local midnight of this date.
  DateTime toDateTime() => DateTime(year, month, day);

  /// Local [DateTime] on this date at [hour]:[minute].
  DateTime atTime(int hour, int minute) =>
      DateTime(year, month, day, hour, minute);

  bool isBefore(LocalDate other) => compareTo(other) < 0;
  bool isAfter(LocalDate other) => compareTo(other) > 0;
  bool operator <(LocalDate other) => compareTo(other) < 0;
  bool operator <=(LocalDate other) => compareTo(other) <= 0;
  bool operator >(LocalDate other) => compareTo(other) > 0;
  bool operator >=(LocalDate other) => compareTo(other) >= 0;

  static LocalDate min(LocalDate a, LocalDate b) => a <= b ? a : b;
  static LocalDate max(LocalDate a, LocalDate b) => a >= b ? a : b;

  /// The later of the non-null dates, or null when both are null.
  static LocalDate? maxOrNull(LocalDate? a, LocalDate? b) =>
      a == null ? b : (b == null ? a : max(a, b));

  /// The earlier of the non-null dates, or null when both are null.
  static LocalDate? minOrNull(LocalDate? a, LocalDate? b) =>
      a == null ? b : (b == null ? a : min(a, b));

  @override
  int compareTo(LocalDate other) =>
      (year * 10000 + month * 100 + day) -
      (other.year * 10000 + other.month * 100 + other.day);

  @override
  bool operator ==(Object other) =>
      other is LocalDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  /// `YYYY-MM-DD`.
  String toIso() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  String toString() => toIso();
}
