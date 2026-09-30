import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:expense_tracker/features/settings/settings_data.dart';

/// Keys of the backup preferences this slice owns in the `settings` table.
/// The last backup time belongs to the settings module
/// ([SettingsKeys.lastBackupAt]).
abstract final class BackupKeys {
  static const reminder = 'backup_reminder';
  static const reminderSnoozedUntil = 'backup_reminder_snoozed_until';
  static const autoBackupFolderUri = 'auto_backup_folder_uri';
  static const autoBackupFolderName = 'auto_backup_folder_name';
  static const lastAutoBackupAt = 'last_auto_backup_at';
  static const autoBackupFailed = 'auto_backup_failed';
}

DateTime? _utcMs(String? value) {
  final ms = int.tryParse(value ?? '');
  return ms == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
}

String utcMsOf(DateTime at) => '${at.toUtc().millisecondsSinceEpoch}';

/// Reads [BackupStatus] from key/value rows plus the oldest transaction's
/// `created_at` (UTC epoch ms). Malformed values fall back to defaults.
BackupStatus backupStatusFromRows(
  Map<String, String> rows, {
  required int? firstRecordMs,
}) {
  final folderUri = rows[BackupKeys.autoBackupFolderUri];
  return BackupStatus(
    lastBackupAt: _utcMs(rows[SettingsKeys.lastBackupAt]),
    firstRecordAt: firstRecordMs == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(firstRecordMs, isUtc: true),
    reminderEnabled: rows[BackupKeys.reminder] != 'false',
    reminderSnoozedUntil: _utcMs(rows[BackupKeys.reminderSnoozedUntil]),
    autoBackupFolder: folderUri == null || folderUri.isEmpty
        ? null
        : BackupFolder(
            uri: folderUri,
            name: rows[BackupKeys.autoBackupFolderName] ?? '',
          ),
    lastAutoBackupAt: _utcMs(rows[BackupKeys.lastAutoBackupAt]),
    autoBackupFailed: rows[BackupKeys.autoBackupFailed] == 'true',
  );
}
