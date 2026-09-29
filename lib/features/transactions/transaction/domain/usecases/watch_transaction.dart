import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchTransaction {
  const WatchTransaction(this._repository);

  final TransactionRepository _repository;

  Stream<Either<Failure, TransactionView?>> call(String id) =>
      _repository.watch(id);
}
