import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateAccount {
  const CreateAccount(this._repository);

  final AccountRepository _repository;

  Future<Either<Failure, Account>> call(AccountInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        _repository.create,
      );
}
