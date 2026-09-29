import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TransactionRepository {
  /// Inserts [input] and remembers its category/account as last used for
  /// its type, in one DB transaction.
  Future<Either<Failure, Transaction>> add(TransactionInput input);

  Future<Either<Failure, Unit>> update(String id, TransactionInput input);

  /// Deletes and returns the row, so it can be restored for undo.
  Future<Either<Failure, Transaction>> delete(String id);

  /// Re-inserts [transaction] exactly as it was, same id and timestamps.
  Future<Either<Failure, Unit>> restore(Transaction transaction);

  Future<Either<Failure, Transaction>> get(String id);

  /// Emits null once the transaction is deleted.
  Stream<Either<Failure, TransactionView?>> watch(String id);

  /// Newest first, by date then time then creation.
  Stream<Either<Failure, List<TransactionView>>> watchRecent(int limit);

  Future<Either<Failure, LastUsed>> getLastUsed(TransactionType type);

  Future<Either<Failure, Unit>> setLastUsed(
    TransactionType type,
    LastUsed value,
  );
}
