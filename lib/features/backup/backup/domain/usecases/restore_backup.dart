import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:fpdart/fpdart.dart';

class RestoreBackup {
  const RestoreBackup(this._repository);

  final BackupRepository _repository;

  Future<Either<Failure, Unit>> call(BackupFile file, RestoreMode mode) =>
      _repository.restore(file, mode);
}
