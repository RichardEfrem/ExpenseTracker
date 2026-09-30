import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Local times, as the clock gives them.
  final now = DateTime(2026, 9, 30, 9);
  DateTime daysAgo(int days, {int hour = 9}) =>
      DateTime(2026, 9, 30 - days, hour);
  const folder = BackupFolder(uri: 'content://tree/x', name: 'Backups');

  group('reminderDue', () {
    test('29 days since the last backup: not yet', () {
      expect(BackupStatus(lastBackupAt: daysAgo(29)).reminderDue(now), isNull);
    });

    test('30 days: due, with the day count', () {
      expect(
        BackupStatus(lastBackupAt: daysAgo(30)).reminderDue(now),
        const BackupReminderDue(daysSinceBackup: 30),
      );
    });

    test('counts calendar days, not 24-hour spans', () {
      // 29 days and a few hours, but 30 calendar days ago.
      final late = BackupStatus(lastBackupAt: daysAgo(30, hour: 23));
      expect(late.reminderDue(now)?.daysSinceBackup, 30);
    });

    test('UTC timestamps are compared in local time', () {
      final status = BackupStatus(lastBackupAt: daysAgo(31).toUtc());
      expect(status.reminderDue(now)?.daysSinceBackup, 31);
    });

    test('never backed up: counts from the first transaction', () {
      expect(BackupStatus(firstRecordAt: daysAgo(10)).reminderDue(now), isNull);
      expect(
        BackupStatus(firstRecordAt: daysAgo(45)).reminderDue(now),
        const BackupReminderDue(),
      );
    });

    test('never backed up and no transactions: no reminder', () {
      expect(const BackupStatus().reminderDue(now), isNull);
    });

    test('turned off: never', () {
      final status = BackupStatus(
        lastBackupAt: daysAgo(90),
        reminderEnabled: false,
      );
      expect(status.reminderDue(now), isNull);
    });

    test('snoozed until later: hidden, then back', () {
      final status = BackupStatus(
        lastBackupAt: daysAgo(40),
        reminderSnoozedUntil: now.add(const Duration(hours: 1)),
      );
      expect(status.reminderDue(now), isNull);
      expect(status.reminderDue(now.add(const Duration(hours: 2))), isNotNull);
    });

    test('a backup after the snooze clears it for another 30 days', () {
      final status = BackupStatus(
        lastBackupAt: daysAgo(1),
        reminderSnoozedUntil: daysAgo(5),
      );
      expect(status.reminderDue(now), isNull);
    });
  });

  group('autoBackupDue', () {
    test('off without a folder', () {
      expect(const BackupStatus().autoBackupDue(now), isFalse);
    });

    test('due right after choosing a folder', () {
      expect(
        const BackupStatus(autoBackupFolder: folder).autoBackupDue(now),
        isTrue,
      );
    });

    test('weekly: 6 days no, 7 days yes', () {
      BackupStatus after(int days) => BackupStatus(
        autoBackupFolder: folder,
        lastAutoBackupAt: daysAgo(days),
      );
      expect(after(6).autoBackupDue(now), isFalse);
      expect(after(7).autoBackupDue(now), isTrue);
    });

    test('a failed attempt retries on the next check', () {
      final status = BackupStatus(
        autoBackupFolder: folder,
        lastAutoBackupAt: daysAgo(8),
        autoBackupFailed: true,
      );
      expect(status.autoBackupDue(now), isTrue);
    });
  });
}
