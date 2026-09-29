import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/trends/domain/entities/month_totals.dart';
import 'package:expense_tracker/features/reports/trends/domain/repositories/trends_repository.dart';
import 'package:fpdart/fpdart.dart';

/// The last [monthCount] month periods up to the one holding the end of
/// [scope]'s period, oldest first (PRD RPT-02).
class WatchTrends {
  const WatchTrends(this._repository);

  final TrendsRepository _repository;

  static List<Period> monthsEnding(
    Period period,
    int monthCount,
    int monthStartDay,
  ) {
    final last = Period.monthContaining(period.end, startDay: monthStartDay);
    return [
      for (var i = monthCount - 1; i >= 0; i--)
        () {
          var p = last;
          for (var j = 0; j < i; j++) {
            p = p.previous();
          }
          return p;
        }(),
    ];
  }

  Stream<Either<Failure, List<MonthTotals>>> call(
    ReportScope scope, {
    required int monthCount,
    required int monthStartDay,
  }) => _repository.watch(
    monthsEnding(scope.period, monthCount, monthStartDay),
    scope.accountIds,
  );
}
