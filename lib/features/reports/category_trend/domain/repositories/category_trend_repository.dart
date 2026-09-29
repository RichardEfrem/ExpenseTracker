import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CategoryTrendRepository {
  /// Totals per category for each of [months], oldest first.
  Stream<Either<Failure, CategoryTrend>> watch(
    List<Period> months,
    Set<String> accountIds,
  );
}
