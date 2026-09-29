import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:expense_tracker/features/reports/daily/domain/repositories/daily_repository.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

class WatchDailySpending {
  const WatchDailySpending(this._repository);

  final DailyRepository _repository;

  Stream<Either<Failure, DailySpending>> call(
    ReportScope scope,
    LocalDate today,
  ) => _repository.watch(scope, today);
}
