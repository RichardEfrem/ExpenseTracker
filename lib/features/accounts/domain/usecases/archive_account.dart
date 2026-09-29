import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Hides an account from pickers; its history stays (PRD data integrity).
class ArchiveAccount {
  const ArchiveAccount(this._repository);

  final AccountRepository _repository;

  Future<Either<Failure, Unit>> call(String id, {bool archived = true}) =>
      _repository.setArchived(id, archived: archived);
}
