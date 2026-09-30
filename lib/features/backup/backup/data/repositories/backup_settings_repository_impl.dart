import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_secret_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/models/backup_settings_model.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:expense_tracker/features/settings/settings_data.dart';
import 'package:fpdart/fpdart.dart';

class BackupSettingsRepositoryImpl implements BackupSettingsRepository {
  const BackupSettingsRepositoryImpl(this._local, this._secret);

  final BackupLocalDataSource _local;
  final BackupSecretDataSource _secret;

  static BackupStatus _status(
    ({Map<String, String> settings, int? firstRecordMs}) rows,
  ) => backupStatusFromRows(rows.settings, firstRecordMs: rows.firstRecordMs);

  @override
  Stream<Either<Failure, BackupStatus>> watchStatus() =>
      guardStream(_local.watchStatusRows().map(_status).distinct());

  @override
  Future<Either<Failure, BackupStatus>> getStatus() =>
      guard(() async => _status(await _local.readStatusRows()));

  @override
  Future<Either<Failure, Unit>> setReminderEnabled(bool enabled) =>
      _put({BackupKeys.reminder: '$enabled'});

  @override
  Future<Either<Failure, Unit>> snoozeReminderUntil(DateTime until) =>
      _put({BackupKeys.reminderSnoozedUntil: utcMsOf(until)});

  @override
  Future<Either<Failure, Unit>> setAutoBackupFolder(BackupFolder? folder) =>
      guard(() async {
        if (folder == null) {
          await _local.deleteSettings(const [
            BackupKeys.autoBackupFolderUri,
            BackupKeys.autoBackupFolderName,
            BackupKeys.lastAutoBackupAt,
            BackupKeys.autoBackupFailed,
          ]);
        } else {
          // A new folder gets its first backup on the next check.
          await _local.deleteSettings(const [BackupKeys.lastAutoBackupAt]);
          await _local.putSettings({
            BackupKeys.autoBackupFolderUri: folder.uri,
            BackupKeys.autoBackupFolderName: folder.name,
            BackupKeys.autoBackupFailed: 'false',
          });
        }
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> recordAutoBackup(
    DateTime at, {
    required bool succeeded,
  }) => _put({
    BackupKeys.autoBackupFailed: '${!succeeded}',
    if (succeeded) ...{
      BackupKeys.lastAutoBackupAt: utcMsOf(at),
      SettingsKeys.lastBackupAt: utcMsOf(at),
    },
  });

  @override
  Future<Either<Failure, String?>> readPassword() =>
      guard(_secret.readPassword);

  @override
  Future<Either<Failure, Unit>> setPassword(String? password) =>
      guard(() async {
        await _secret.writePassword(password);
        return unit;
      });

  Future<Either<Failure, Unit>> _put(Map<String, String> values) =>
      guard(() async {
        await _local.putSettings(values);
        return unit;
      });
}
