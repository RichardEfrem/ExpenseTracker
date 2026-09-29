import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

/// "Add again" (PRD TX-08): a copy of a transaction dated now.
class DuplicateTransaction {
  const DuplicateTransaction(this._repository, this._clock);

  final TransactionRepository _repository;
  final Clock _clock;

  Future<Either<Failure, Transaction>> call(String id) async {
    final original = await _repository.get(id);
    return original.match((failure) async => Left(failure), (t) {
      final now = _clock.now();
      return _repository.add(
        TransactionInput(
          type: t.type,
          amount: t.amount,
          accountId: t.accountId,
          toAccountId: t.toAccountId,
          categoryId: t.categoryId,
          date: LocalDate.fromDateTime(now),
          time: LocalTime.fromDateTime(now),
          note: t.note,
        ),
      );
    });
  }
}
