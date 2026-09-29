import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/repositories/category_trend_repository.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/trends/domain/usecases/watch_trends.dart';
import 'package:fpdart/fpdart.dart';

/// Category totals over the same months as the Trends chart (PRD RPT-04).
class WatchCategoryTrend {
  const WatchCategoryTrend(this._repository);

  final CategoryTrendRepository _repository;

  Stream<Either<Failure, CategoryTrend>> call(
    ReportScope scope, {
    required int monthCount,
    required int monthStartDay,
  }) => _repository.watch(
    WatchTrends.monthsEnding(scope.period, monthCount, monthStartDay),
    scope.accountIds,
  );
}
