import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/data/accounts_providers.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'accounts_notifier.g.dart';

/// Accounts in sort order (active only unless [includeArchived]).
@riverpod
class AccountsNotifier extends _$AccountsNotifier {
  @override
  Stream<List<Account>> build({bool includeArchived = false}) => ref
      .watch(watchAccountsProvider)(includeArchived: includeArchived)
      .unwrap();
}

/// The account preselected for new transactions.
@riverpod
class DefaultAccountNotifier extends _$DefaultAccountNotifier {
  @override
  Future<Account> build() async =>
      (await ref.watch(getDefaultAccountProvider)()).getOrThrow();
}

/// Every account with its balance today (PRD ACC-03).
@riverpod
class AccountBalancesNotifier extends _$AccountBalancesNotifier {
  @override
  Stream<List<AccountBalance>> build() => ref
      .watch(watchAccountBalancesProvider)(
        LocalDate.today(ref.watch(clockProvider)),
      )
      .unwrap();
}

/// Month-end balances over the last [months] months (PRD RPT-07).
@riverpod
class BalanceHistoryNotifier extends _$BalanceHistoryNotifier {
  @override
  Stream<BalanceHistory> build(int months) => ref
      .watch(watchBalanceHistoryProvider)(
        LocalDate.today(ref.watch(clockProvider)),
        months,
      )
      .unwrap();
}

/// Account writes; each returns its failure (or null) for the UI to show.
@riverpod
class AccountActions extends _$AccountActions {
  @override
  void build() {}

  Future<Either<Failure, Account>> create(AccountInput input) =>
      ref.read(createAccountProvider)(input);

  Future<Failure?> update(String id, AccountInput input) async =>
      (await ref.read(updateAccountProvider)(id, input)).failureOrNull;

  Future<Failure?> setArchived(String id, {required bool archived}) async =>
      (await ref.read(archiveAccountProvider)(
        id,
        archived: archived,
      )).failureOrNull;

  Future<Failure?> delete(String id) async =>
      (await ref.read(deleteAccountProvider)(id)).failureOrNull;

  /// Right(adjustment amount); 0 when the balance was already right.
  Future<Either<Failure, int>> adjust(String id, int actualBalance) =>
      ref.read(adjustBalanceProvider)(id, actualBalance);
}
