import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/repositories/category_breakdown_repository.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/category_total.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

class CategoryBreakdownRepositoryImpl implements CategoryBreakdownRepository {
  const CategoryBreakdownRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, CategoryBreakdown>> watch(
    ReportScope scope,
    CategoryType type,
  ) => guardStream(
    _dataSource.watch(() async {
      final rows = await _dataSource.byCategory(scope, type.name);
      return CategoryBreakdown(
        type: type,
        totals: [
          for (final (row, amount, count) in rows)
            CategoryTotal(
              category: row.toEntity(),
              amount: amount,
              count: count,
            ),
        ],
      );
    }),
  );
}
