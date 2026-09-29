import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_balance.freezed.dart';

/// An account's balance: opening + income − expense ± transfers ±
/// adjustments (PRD ACC-03, ACC-05).
@Freezed(copyWith: false)
abstract class AccountBalance with _$AccountBalance {
  const factory AccountBalance({
    required Account account,
    required int balance,
  }) = _AccountBalance;
}

/// Balance of each account at each of [dates] (PRD RPT-07).
@Freezed(copyWith: false)
abstract class BalanceHistory with _$BalanceHistory {
  const factory BalanceHistory({
    /// Oldest first.
    required List<LocalDate> dates,
    required List<Account> accounts,

    /// Account id → balance at each of [dates].
    required Map<String, List<int>> series,
  }) = _BalanceHistory;

  const BalanceHistory._();

  /// Sum of all accounts at each date.
  List<int> get totals => [
    for (var i = 0; i < dates.length; i++)
      series.values.fold(0, (sum, s) => sum + s[i]),
  ];
}
