import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/pagination/paged_result.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/day_group.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/filter_summary.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ActivityRepository {
  /// The transactions matching [filter] inside [cursor], grouped by day,
  /// newest first. `hasMore` is true when matches exist before [cursor].
  Stream<Either<Failure, PagedResult<DayGroup>>> watchPage(
    TransactionFilter filter,
    Period cursor,
  );

  Stream<Either<Failure, FilterSummary>> watchSummary(TransactionFilter filter);
}
