import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateAccount {
  const UpdateAccount(this._repository);

  final AccountRepository _repository;

  Future<Either<Failure, Unit>> call(String id, AccountInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        (valid) => _repository.update(id, valid),
      );
}
