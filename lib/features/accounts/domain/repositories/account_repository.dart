import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AccountRepository {
  /// Accounts in sort order; archived ones only when [includeArchived].
  Stream<Either<Failure, List<Account>>> watchAll({
    bool includeArchived = false,
  });

  /// The first active account in sort order ("Cash" on a new install).
  Future<Either<Failure, Account>> getDefault();

  Future<Either<Failure, Account>> create(AccountInput input);

  Future<Either<Failure, Unit>> update(String id, AccountInput input);

  /// Fails with [ValidationReason.lastActiveAccount] when archiving the
  /// only active account.
  Future<Either<Failure, Unit>> setArchived(
    String id, {
    required bool archived,
  });

  /// Fails with [ValidationReason.accountInUse] if any transaction or
  /// recurring rule uses it.
  Future<Either<Failure, Unit>> delete(String id);

  /// Every account's balance as of [asOf] (inclusive), archived included.
  Stream<Either<Failure, List<AccountBalance>>> watchBalances(LocalDate asOf);

  /// Balance of every active account at each of [dates] (ascending).
  Stream<Either<Failure, BalanceHistory>> watchHistory(List<LocalDate> dates);

  /// Records an adjustment so the balance becomes [actualBalance]; no-op
  /// when it already is (PRD ACC-05). Returns the adjustment amount.
  Future<Either<Failure, int>> adjustBalance(
    String accountId,
    int actualBalance, {
    required LocalDate date,
    required LocalTime time,
  });
}
