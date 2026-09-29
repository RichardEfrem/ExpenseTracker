import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CategoryBreakdownRepository {
  Stream<Either<Failure, CategoryBreakdown>> watch(
    ReportScope scope,
    CategoryType type,
  );
}
