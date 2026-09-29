import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/repositories/category_trend_repository.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:fpdart/fpdart.dart';

class CategoryTrendRepositoryImpl implements CategoryTrendRepository {
  const CategoryTrendRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, CategoryTrend>> watch(
    List<Period> months,
    Set<String> accountIds,
  ) => guardStream(
    _dataSource.watch(
      () async => CategoryTrend.of(months, [
        for (final row in await _dataSource.byCategoryPerPeriod(
          months,
          accountIds,
        ))
          (row.bucket, row.category.toEntity(), row.amount),
      ]),
    ),
  );
}
