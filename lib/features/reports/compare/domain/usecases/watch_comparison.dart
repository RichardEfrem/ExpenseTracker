import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:expense_tracker/features/reports/compare/domain/repositories/compare_repository.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

/// What changed against the previous period, per category (PRD RPT-05).
class WatchComparison {
  const WatchComparison(this._repository);

  final CompareRepository _repository;

  Stream<Either<Failure, PeriodComparison>> call(
    ReportScope scope,
    CategoryType type,
  ) => _repository.watch(scope, type);
}
