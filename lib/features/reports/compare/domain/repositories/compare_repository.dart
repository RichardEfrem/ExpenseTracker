import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CompareRepository {
  /// [scope]'s period against the one before it, for [type].
  Stream<Either<Failure, PeriodComparison>> watch(
    ReportScope scope,
    CategoryType type,
  );
}
