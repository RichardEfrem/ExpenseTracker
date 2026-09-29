import 'package:expense_tracker/core/utils/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'month_totals.freezed.dart';

/// Income and expense of one month period (PRD RPT-02).
@freezed
abstract class MonthTotals with _$MonthTotals {
  const factory MonthTotals({
    required Period period,
    required int income,
    required int expense,
  }) = _MonthTotals;

  const MonthTotals._();

  int get net => income - expense;
}
