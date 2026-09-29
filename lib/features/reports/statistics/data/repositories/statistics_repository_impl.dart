import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/statistics/domain/entities/period_statistics.dart';
import 'package:expense_tracker/features/reports/statistics/domain/repositories/statistics_repository.dart';
import 'package:fpdart/fpdart.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  const StatisticsRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, PeriodStatistics>> watch(
    ReportScope scope,
    LocalDate today,
  ) => guardStream(
    _dataSource.watch(() async {
      final current = await _dataSource.totals(scope);
      final previous = await _dataSource.totals(scope.previous);
      final largest = await _dataSource.largestExpense(scope);
      final frequent = await _dataSource.mostFrequentCategory(scope);
      final largestCategory = largest?.categoryId == null
          ? null
          : await _dataSource.category(largest!.categoryId!);
      final frequentCategory = frequent == null
          ? null
          : await _dataSource.category(frequent.categoryId);
      return PeriodStatistics(
        period: scope.period,
        today: today,
        income: current.income,
        expense: current.expense,
        previousIncome: previous.income,
        previousExpense: previous.expense,
        expenseDays: await _dataSource.expenseDayCount(scope, today),
        largestExpense: largest == null
            ? null
            : LargestExpense(
                transactionId: largest.id,
                amount: largest.amount,
                date: largest.date,
                category: largestCategory?.toEntity(),
              ),
        mostFrequentCategory: frequentCategory == null
            ? null
            : CategoryCount(
                category: frequentCategory.toEntity(),
                count: frequent!.count,
              ),
      );
    }),
  );

  @override
  Future<Either<Failure, LocalDate?>> latestDateBefore(
    LocalDate date,
    Set<String> accountIds,
  ) => guard(() => _dataSource.latestDateBefore(date, accountIds));
}
