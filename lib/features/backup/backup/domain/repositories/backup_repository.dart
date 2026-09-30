import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
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

  /// True when [contents] is an encrypted backup (PRD BAK-03).
  bool isEncrypted(String contents);

  /// Encrypts an encoded backup with [password] (AES-256-GCM, key from
  /// PBKDF2).
  Future<Either<Failure, String>> encrypt(String contents, String password);

  /// The encoded backup inside an encrypted one. A wrong password or a
  /// changed file fails with [BackupProblem.wrongPassword].
  Future<Either<Failure, String>> decrypt(String contents, String password);

  /// True when the file was delivered, false when the user cancelled.
  Future<Either<Failure, bool>> deliver(
    String contents,
    String fileName,
    ExportTarget target,
  );

  /// The picked file's text, or null when cancelled.
  Future<Either<Failure, String?>> pickFile();

  /// Asks the user for a folder and keeps access to it; null when
  /// cancelled.
  Future<Either<Failure, BackupFolder?>> pickFolder();

  /// Gives up access to a folder picked earlier.
  Future<Either<Failure, Unit>> releaseFolder(BackupFolder folder);

  /// Writes a new file into [folder] without asking the user.
  Future<Either<Failure, Unit>> writeToFolder(
    BackupFolder folder,
    String fileName,
    String contents,
  );

  Future<Either<Failure, Unit>> recordBackup(DateTime at);
}
