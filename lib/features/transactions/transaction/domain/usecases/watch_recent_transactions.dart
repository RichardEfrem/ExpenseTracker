import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchRecentTransactions {
  const WatchRecentTransactions(this._repository);

  final TransactionRepository _repository;

  Stream<Either<Failure, List<TransactionView>>> call(int limit) =>
      _repository.watchRecent(limit);
}
