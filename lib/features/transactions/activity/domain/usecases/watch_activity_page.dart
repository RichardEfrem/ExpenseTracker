import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/pagination/paged_result.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/day_group.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/activity/domain/repositories/activity_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchActivityPage {
  const WatchActivityPage(this._repository);

  final ActivityRepository _repository;

  Stream<Either<Failure, PagedResult<DayGroup>>> call(
    TransactionFilter filter,
    Period cursor,
  ) => _repository.watchPage(filter, cursor);
}
