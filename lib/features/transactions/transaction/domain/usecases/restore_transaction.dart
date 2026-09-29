import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class RestoreTransaction {
  const RestoreTransaction(this._repository);

  final TransactionRepository _repository;

  Future<Either<Failure, Unit>> call(Transaction transaction) =>
      _repository.restore(transaction);
}
