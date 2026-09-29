import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_spending.freezed.dart';

/// Expense per day of a period (PRD RPT-03).
@freezed
abstract class DailySpending with _$DailySpending {
  const factory DailySpending({
    required Period period,
    required LocalDate today,

    /// Days with spending; others are zero.
    required Map<LocalDate, int> byDay,
  }) = _DailySpending;

  const DailySpending._();

  /// Every day of the period in order, with its expense.
  List<(LocalDate, int)> get days => [
    for (var i = 0; i < period.lengthInDays; i++)
      (period.start.addDays(i), byDay[period.start.addDays(i)] ?? 0),
  ];

  int get total => byDay.values.fold(0, (sum, v) => sum + v);

  /// Total / days elapsed (half up); null before the period starts.
  int? get average {
    final days = period.daysElapsed(today);
    return days == 0 ? null : (2 * total + days) ~/ (2 * days);
  }

  bool get isEmpty => byDay.isEmpty;
}
