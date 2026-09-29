import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:expense_tracker/features/reports/daily/domain/repositories/daily_repository.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

class DailyRepositoryImpl implements DailyRepository {
  const DailyRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, DailySpending>> watch(
    ReportScope scope,
    LocalDate today,
  ) => guardStream(
    _dataSource.watch(
      () async => DailySpending(
        period: scope.period,
        today: today,
        byDay: await _dataSource.dailyExpense(scope),
      ),
    ),
  );
}
