import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/transactions/transaction/data/transaction_providers.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_notifiers.g.dart';

/// One transaction with its category and accounts; null once deleted.
@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  @override
  Stream<TransactionView?> build(String id) =>
      ref.watch(watchTransactionProvider)(id).unwrap();
}

/// The newest [limit] transactions.
@riverpod
class RecentTransactionsNotifier extends _$RecentTransactionsNotifier {
  @override
  Stream<List<TransactionView>> build(int limit) =>
      ref.watch(watchRecentTransactionsProvider)(limit).unwrap();
}

/// Row-level writes. Watched lists update themselves.
@riverpod
class TransactionActions extends _$TransactionActions {
  @override
  void build() {}

  /// Returns the deleted transaction, for undo.
  Future<Either<Failure, Transaction>> delete(String id) =>
      ref.read(deleteTransactionProvider)(id);

  Future<Failure?> restore(Transaction transaction) async =>
      (await ref.read(restoreTransactionProvider)(transaction)).failureOrNull;

  Future<Either<Failure, Transaction>> duplicate(String id) =>
      ref.read(duplicateTransactionProvider)(id);
}
