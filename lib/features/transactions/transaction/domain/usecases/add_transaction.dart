import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddTransaction {
  const AddTransaction(this._repository);

  final TransactionRepository _repository;

  Future<Either<Failure, Transaction>> call(TransactionInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        _repository.add,
      );
}
