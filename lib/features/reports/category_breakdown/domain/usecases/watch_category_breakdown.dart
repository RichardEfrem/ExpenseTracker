import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/repositories/category_breakdown_repository.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

class WatchCategoryBreakdown {
  const WatchCategoryBreakdown(this._repository);

  final CategoryBreakdownRepository _repository;

  Stream<Either<Failure, CategoryBreakdown>> call(
    ReportScope scope,
    CategoryType type,
  ) => _repository.watch(scope, type);
}
