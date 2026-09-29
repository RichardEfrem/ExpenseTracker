import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Lets the user pick a backup and reads it; Right(null) when cancelled.
/// Use `file.preview` to show counts and date range before restoring.
class PreviewBackup {
  const PreviewBackup(this._repository);

  final BackupRepository _repository;

  Future<Either<Failure, BackupFile?>> call() async {
    final picked = await _repository.pickFile();
    return picked.flatMap(
      (contents) =>
          contents == null ? const Right(null) : _repository.decode(contents),
    );
  }
}
