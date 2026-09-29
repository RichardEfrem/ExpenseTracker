import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateTransaction {
  const UpdateTransaction(this._repository);

  final TransactionRepository _repository;

  Future<Either<Failure, Unit>> call(String id, TransactionInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        (valid) => _repository.update(id, valid),
      );
}
