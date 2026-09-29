import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/trends/domain/entities/month_totals.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TrendsRepository {
  /// Totals for each of [months] in order; months without data are zero.
  Stream<Either<Failure, List<MonthTotals>>> watch(
    List<Period> months,
    Set<String> accountIds,
  );
}
