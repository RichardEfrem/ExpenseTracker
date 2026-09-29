import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetDefaultAccount {
  const GetDefaultAccount(this._repository);

  final AccountRepository _repository;

  Future<Either<Failure, Account>> call() => _repository.getDefault();
}
