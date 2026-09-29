import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:expense_tracker/features/reports/compare/domain/repositories/compare_repository.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

class CompareRepositoryImpl implements CompareRepository {
  const CompareRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, PeriodComparison>> watch(
    ReportScope scope,
    CategoryType type,
  ) => guardStream(
    _dataSource.watch(() async {
      final previous = scope.previous.period;
      final rows = await _dataSource.byCategoryPerPeriod(
        [previous, scope.period],
        scope.accountIds,
        type: type.name,
      );
      List<(Category, int)> totalsOf(int bucket) => [
        for (final row in rows)
          if (row.bucket == bucket) (row.category.toEntity(), row.amount),
      ];
      return PeriodComparison.of(
        type: type,
        current: scope.period,
        previous: previous,
        currentTotals: totalsOf(1),
        previousTotals: totalsOf(0),
      );
    }),
  );
}
