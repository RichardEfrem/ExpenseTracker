import 'package:expense_tracker/core/utils/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_scope.freezed.dart';

/// What every report covers: a period and which accounts (PRD §5).
@freezed
abstract class ReportScope with _$ReportScope {
  const factory ReportScope({
    required Period period,

    /// Empty means all accounts.
    @Default(<String>{}) Set<String> accountIds,
  }) = _ReportScope;

  const ReportScope._();

  ReportScope get previous => copyWith(period: period.previous());
}
