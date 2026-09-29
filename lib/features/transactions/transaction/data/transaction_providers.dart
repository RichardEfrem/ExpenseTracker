import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/uuid_provider.dart';
import 'package:expense_tracker/features/transactions/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:expense_tracker/features/transactions/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/add_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/delete_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/duplicate_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/evaluate_amount_expression.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/get_last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/get_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/restore_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/set_last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/update_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/watch_recent_transactions.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/watch_transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_providers.g.dart';

@riverpod
TransactionLocalDataSource transactionLocalDataSource(Ref ref) =>
    TransactionLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
TransactionRepository transactionRepository(Ref ref) =>
    TransactionRepositoryImpl(
      ref.watch(transactionLocalDataSourceProvider),
      ref.watch(clockProvider),
      ref.watch(idGeneratorProvider),
    );

@riverpod
AddTransaction addTransaction(Ref ref) =>
    AddTransaction(ref.watch(transactionRepositoryProvider));

@riverpod
UpdateTransaction updateTransaction(Ref ref) =>
    UpdateTransaction(ref.watch(transactionRepositoryProvider));

@riverpod
DeleteTransaction deleteTransaction(Ref ref) =>
    DeleteTransaction(ref.watch(transactionRepositoryProvider));

@riverpod
RestoreTransaction restoreTransaction(Ref ref) =>
    RestoreTransaction(ref.watch(transactionRepositoryProvider));

@riverpod
DuplicateTransaction duplicateTransaction(Ref ref) => DuplicateTransaction(
  ref.watch(transactionRepositoryProvider),
  ref.watch(clockProvider),
);

@riverpod
GetTransaction getTransaction(Ref ref) =>
    GetTransaction(ref.watch(transactionRepositoryProvider));

@riverpod
WatchTransaction watchTransaction(Ref ref) =>
    WatchTransaction(ref.watch(transactionRepositoryProvider));

@riverpod
WatchRecentTransactions watchRecentTransactions(Ref ref) =>
    WatchRecentTransactions(ref.watch(transactionRepositoryProvider));

@riverpod
GetLastUsed getLastUsed(Ref ref) =>
    GetLastUsed(ref.watch(transactionRepositoryProvider));

@riverpod
SetLastUsed setLastUsed(Ref ref) =>
    SetLastUsed(ref.watch(transactionRepositoryProvider));

@riverpod
EvaluateAmountExpression evaluateAmountExpression(Ref ref) =>
    const EvaluateAmountExpression();
