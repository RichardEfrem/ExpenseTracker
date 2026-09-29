import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteAccount {
  const DeleteAccount(this._repository);

  final AccountRepository _repository;

  Future<Either<Failure, Unit>> call(String id) => _repository.delete(id);
}
