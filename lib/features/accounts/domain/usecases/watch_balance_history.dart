import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Balances at the end of each of the last [months] months, the current
/// month ending today (PRD RPT-07).
class WatchBalanceHistory {
  const WatchBalanceHistory(this._repository);

  final AccountRepository _repository;

  static List<LocalDate> monthEnds(LocalDate today, int months) => [
    for (var i = months - 1; i > 0; i--)
      today.firstOfMonth.addMonths(-i).lastOfMonth,
    today,
  ];

  Stream<Either<Failure, BalanceHistory>> call(LocalDate today, int months) =>
      _repository.watchHistory(monthEnds(today, months));
}
