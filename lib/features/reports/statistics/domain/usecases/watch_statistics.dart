import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/statistics/domain/entities/period_statistics.dart';
import 'package:expense_tracker/features/reports/statistics/domain/repositories/statistics_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchStatistics {
  const WatchStatistics(this._repository);

  final StatisticsRepository _repository;

  Stream<Either<Failure, PeriodStatistics>> call(
    ReportScope scope,
    LocalDate today,
  ) => _repository.watch(scope, today);
}
