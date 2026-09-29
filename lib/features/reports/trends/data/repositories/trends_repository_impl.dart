import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/trends/domain/entities/month_totals.dart';
import 'package:expense_tracker/features/reports/trends/domain/repositories/trends_repository.dart';
import 'package:fpdart/fpdart.dart';

class TrendsRepositoryImpl implements TrendsRepository {
  const TrendsRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, List<MonthTotals>>> watch(
    List<Period> months,
    Set<String> accountIds,
  ) => guardStream(
    _dataSource.watch(() async {
      final rows = {
        for (final row in await _dataSource.byPeriods(months, accountIds))
          row.bucket: row,
      };
      return [
        for (final (i, period) in months.indexed)
          MonthTotals(
            period: period,
            income: rows[i]?.income ?? 0,
            expense: rows[i]?.expense ?? 0,
          ),
      ];
    }),
  );
}
