import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:fpdart/fpdart.dart';

/// Where an exported file goes.
enum ExportTarget { share, saveToDevice }

abstract interface class BackupRepository {
  /// Everything in the database right now.
  Future<Either<Failure, BackupFile>> snapshot({required String appVersion});

  /// Writes [file] in one DB transaction: all of it or none of it.
  Future<Either<Failure, Unit>> restore(BackupFile file, RestoreMode mode);

  /// Deletes all data, then seeds the defaults of a fresh install.
  Future<Either<Failure, Unit>> eraseAll();

  Either<Failure, String> encode(BackupFile file);

  /// Fails with a [BackupFailure] for empty, corrupt or too-new files.
  Either<Failure, BackupFile> decode(String contents);

  /// True when the file was delivered, false when the user cancelled.
  Future<Either<Failure, bool>> deliver(
    String contents,
    String fileName,
    ExportTarget target,
  );

  /// The picked file's text, or null when cancelled.
  Future<Either<Failure, String?>> pickFile();

  Future<Either<Failure, Unit>> recordBackup(DateTime at);
}
