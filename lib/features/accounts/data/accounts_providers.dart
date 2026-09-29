import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/uuid_provider.dart';
import 'package:expense_tracker/features/accounts/data/datasources/account_local_datasource.dart';
import 'package:expense_tracker/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/adjust_balance.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/archive_account.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/create_account.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/delete_account.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/get_default_account.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/update_account.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/watch_balance_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_providers.g.dart';

@riverpod
AccountLocalDataSource accountLocalDataSource(Ref ref) =>
    AccountLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
AccountRepository accountRepository(Ref ref) => AccountRepositoryImpl(
  ref.watch(accountLocalDataSourceProvider),
  ref.watch(clockProvider),
  ref.watch(idGeneratorProvider),
);

@riverpod
WatchAccounts watchAccounts(Ref ref) =>
    WatchAccounts(ref.watch(accountRepositoryProvider));

@riverpod
GetDefaultAccount getDefaultAccount(Ref ref) =>
    GetDefaultAccount(ref.watch(accountRepositoryProvider));

@riverpod
CreateAccount createAccount(Ref ref) =>
    CreateAccount(ref.watch(accountRepositoryProvider));

@riverpod
UpdateAccount updateAccount(Ref ref) =>
    UpdateAccount(ref.watch(accountRepositoryProvider));

@riverpod
ArchiveAccount archiveAccount(Ref ref) =>
    ArchiveAccount(ref.watch(accountRepositoryProvider));

@riverpod
DeleteAccount deleteAccount(Ref ref) =>
    DeleteAccount(ref.watch(accountRepositoryProvider));

@riverpod
WatchAccountBalances watchAccountBalances(Ref ref) =>
    WatchAccountBalances(ref.watch(accountRepositoryProvider));

@riverpod
WatchBalanceHistory watchBalanceHistory(Ref ref) =>
    WatchBalanceHistory(ref.watch(accountRepositoryProvider));

@riverpod
AdjustBalance adjustBalance(Ref ref) => AdjustBalance(
  ref.watch(accountRepositoryProvider),
  ref.watch(clockProvider),
);
