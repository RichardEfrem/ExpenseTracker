import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_status.freezed.dart';

/// A folder the user granted for weekly auto-backups (PRD BAK-05). [uri] is
/// the Storage Access Framework tree URI; [name] is for display.
@freezed
abstract class BackupFolder with _$BackupFolder {
  const factory BackupFolder({required String uri, required String name}) =
      _BackupFolder;
}

/// The Home banner should show (PRD BAK-04). [daysSinceBackup] is null when
/// the user never backed up.
@freezed
abstract class BackupReminderDue with _$BackupReminderDue {
  const factory BackupReminderDue({int? daysSinceBackup}) = _BackupReminderDue;
}

/// When the data was last backed up and the backup preferences.
@freezed
abstract class BackupStatus with _$BackupStatus {
  const factory BackupStatus({
    DateTime? lastBackupAt,

    /// When the oldest transaction was created; null with no transactions.
    DateTime? firstRecordAt,
    @Default(true) bool reminderEnabled,
    DateTime? reminderSnoozedUntil,
    BackupFolder? autoBackupFolder,
    DateTime? lastAutoBackupAt,

    /// The last auto-backup couldn't write to the folder (e.g. access was
    /// revoked, or the backup came from another phone).
    @Default(false) bool autoBackupFailed,
  }) = _BackupStatus;

  const BackupStatus._();

  static const reminderAfterDays = 30;
  static const snooze = Duration(days: 7);
  static const autoBackupEveryDays = 7;

  /// Whole calendar days from [from] to [now], in local time.
  static int _daysBetween(DateTime from, DateTime now) =>
      LocalDate.fromDateTime(
        from.toLocal(),
      ).daysUntil(LocalDate.fromDateTime(now.toLocal()));

  /// Non-null when the backup reminder should show at [now]: reminders on,
  /// not snoozed, and 30+ days since the last backup. Never backed up counts
  /// from the first transaction, so an empty app never nags.
  BackupReminderDue? reminderDue(DateTime now) {
    if (!reminderEnabled) return null;
    final snoozedUntil = reminderSnoozedUntil;
    if (snoozedUntil != null && now.isBefore(snoozedUntil)) return null;
    final since = lastBackupAt ?? firstRecordAt;
    if (since == null || _daysBetween(since, now) < reminderAfterDays) {
      return null;
    }
    return BackupReminderDue(
      daysSinceBackup: lastBackupAt == null
          ? null
          : _daysBetween(lastBackupAt!, now),
    );
  }

  /// A folder is set and the last auto-backup is 7+ days old (or none yet).
  bool autoBackupDue(DateTime now) {
    if (autoBackupFolder == null) return false;
    final last = lastAutoBackupAt;
    return last == null || _daysBetween(last, now) >= autoBackupEveryDays;
  }
}
