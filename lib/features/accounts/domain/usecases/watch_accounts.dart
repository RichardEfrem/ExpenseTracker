import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchAccounts {
  const WatchAccounts(this._repository);

  final AccountRepository _repository;

  Stream<Either<Failure, List<Account>>> call({bool includeArchived = false}) =>
      _repository.watchAll(includeArchived: includeArchived);
}
