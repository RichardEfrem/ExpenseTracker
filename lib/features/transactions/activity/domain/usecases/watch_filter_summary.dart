import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/filter_summary.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/activity/domain/repositories/activity_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchFilterSummary {
  const WatchFilterSummary(this._repository);

  final ActivityRepository _repository;

  Stream<Either<Failure, FilterSummary>> call(TransactionFilter filter) =>
      _repository.watchSummary(filter);
}
