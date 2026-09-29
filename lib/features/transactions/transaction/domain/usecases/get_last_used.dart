import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLastUsed {
  const GetLastUsed(this._repository);

  final TransactionRepository _repository;

  Future<Either<Failure, LastUsed>> call(TransactionType type) =>
      _repository.getLastUsed(type);
}
