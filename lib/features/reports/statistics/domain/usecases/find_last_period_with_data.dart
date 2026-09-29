import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/statistics/domain/repositories/statistics_repository.dart';
import 'package:fpdart/fpdart.dart';

/// "Go to last month with data" for an empty report (DESIGN §7.10): the
/// month period holding the latest transaction before [scope]'s period.
class FindLastPeriodWithData {
  const FindLastPeriodWithData(this._repository);

  final StatisticsRepository _repository;

  Future<Either<Failure, Period?>> call(ReportScope scope) async {
    final result = await _repository.latestDateBefore(
      scope.period.start,
      scope.accountIds,
    );
    return result.map(
      (date) => date == null
          ? null
          : Period.monthContaining(
              date,
              startDay: scope.period.kind == PeriodKind.month
                  ? scope.period.monthStartDay
                  : 1,
            ),
    );
  }
}
