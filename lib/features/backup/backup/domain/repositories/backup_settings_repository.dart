import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:fpdart/fpdart.dart';

/// Backup preferences, status and the backup password.
abstract interface class BackupSettingsRepository {
  Stream<Either<Failure, BackupStatus>> watchStatus();

  Future<Either<Failure, BackupStatus>> getStatus();

  Future<Either<Failure, Unit>> setReminderEnabled(bool enabled);

  Future<Either<Failure, Unit>> snoozeReminderUntil(DateTime until);

  /// Null turns weekly auto-backup off.
  Future<Either<Failure, Unit>> setAutoBackupFolder(BackupFolder? folder);

  /// Records an auto-backup attempt; a success also counts as a backup.
  Future<Either<Failure, Unit>> recordAutoBackup(
    DateTime at, {
    required bool succeeded,
  });

  /// The password new backups are encrypted with; null when backups are
  /// not encrypted. Kept in Android's Keystore-backed storage, never in
  /// the database or its backups.
  Future<Either<Failure, String?>> readPassword();

  /// Null turns encryption off.
  Future<Either<Failure, Unit>> setPassword(String? password);
}
