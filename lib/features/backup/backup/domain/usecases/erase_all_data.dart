import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:fpdart/fpdart.dart';

class EraseAllData {
  const EraseAllData(this._repository);

  final BackupRepository _repository;

  Future<Either<Failure, Unit>> call() => _repository.eraseAll();
}
