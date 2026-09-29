import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_summary.freezed.dart';

/// Count and totals of the transactions matching a filter (PRD SRCH-03).
@freezed
abstract class FilterSummary with _$FilterSummary {
  const factory FilterSummary({
    required int count,
    required int income,
    required int expense,
  }) = _FilterSummary;

  const FilterSummary._();

  int get net => income - expense;
}
