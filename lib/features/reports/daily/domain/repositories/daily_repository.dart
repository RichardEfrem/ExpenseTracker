import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DailyRepository {
  Stream<Either<Failure, DailySpending>> watch(
    ReportScope scope,
    LocalDate today,
  );
}
