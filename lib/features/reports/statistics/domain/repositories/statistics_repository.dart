import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/statistics/domain/entities/period_statistics.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class StatisticsRepository {
  Stream<Either<Failure, PeriodStatistics>> watch(
    ReportScope scope,
    LocalDate today,
  );

  /// Latest income/expense date before [date], or null.
  Future<Either<Failure, LocalDate?>> latestDateBefore(
    LocalDate date,
    Set<String> accountIds,
  );
}
