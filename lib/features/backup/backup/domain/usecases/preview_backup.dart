import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/picked_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Lets the user pick a backup and reads it; Right(null) when cancelled.
/// An encrypted file comes back as [LockedBackup] for [UnlockBackup]. Use
/// `file.preview` to show counts and date range before restoring.
class PreviewBackup {
  const PreviewBackup(this._repository);

  final BackupRepository _repository;

  Future<Either<Failure, PickedBackup?>> call() async {
    final picked = await _repository.pickFile();
    return picked.flatMap((contents) {
      if (contents == null) return const Right(null);
      if (_repository.isEncrypted(contents)) {
        return Right(LockedBackup(contents));
      }
      return _repository.decode(contents).map(ReadableBackup.new);
    });
  }
}

/// Opens an encrypted backup with its password (PRD BAK-03).
class UnlockBackup {
  const UnlockBackup(this._repository);

  final BackupRepository _repository;

  Future<Either<Failure, BackupFile>> call(
    LockedBackup backup,
    String password,
  ) async => (await _repository.decrypt(
    backup.contents,
    password,
  )).flatMap(_repository.decode);
}
