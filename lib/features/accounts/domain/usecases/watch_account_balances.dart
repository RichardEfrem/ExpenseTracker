import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchAccountBalances {
  const WatchAccountBalances(this._repository);

  final AccountRepository _repository;

  Stream<Either<Failure, List<AccountBalance>>> call(LocalDate asOf) =>
      _repository.watchBalances(asOf);
}
