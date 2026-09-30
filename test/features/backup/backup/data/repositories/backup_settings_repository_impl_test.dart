import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_secret_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/repositories/backup_settings_repository_impl.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:flutter_test/flutter_test.dart';

/// Keeps the password in memory instead of the Keystore.
class FakeBackupSecrets implements BackupSecretDataSource {
  String? password;

  @override
  Future<String?> readPassword() async => password;

  @override
  Future<void> writePassword(String? value) async => password = value;
}

void main() {
  late AppDatabase db;
  late FakeBackupSecrets secrets;
  late BackupSettingsRepositoryImpl repo;
  const folder = BackupFolder(uri: 'content://tree/x', name: 'Backups');

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    secrets = FakeBackupSecrets();
    repo = BackupSettingsRepositoryImpl(BackupLocalDataSource(db), secrets);
  });
  tearDown(() => db.close());

  Future<BackupStatus> status() async =>
      (await repo.getStatus()).getOrElse((f) => fail('$f'));

  test('fresh install: defaults, nothing backed up', () async {
    expect(await status(), const BackupStatus());
  });

  test('first record is the oldest transaction creation time', () async {
    final cash = (await db.select(db.accounts).getSingle()).id;
    for (final (id, created) in [('b', 2000), ('a', 1000)]) {
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: id,
              type: 'transfer',
              amount: 1,
              accountId: cash,
              date: '2026-09-01',
              time: '09:00',
              createdAt: created,
              updatedAt: created,
            ),
          );
    }
    expect(
      (await status()).firstRecordAt,
      DateTime.fromMillisecondsSinceEpoch(1000, isUtc: true),
    );
  });

  test('reminder toggle and snooze persist', () async {
    final until = DateTime.utc(2026, 10, 7, 9);
    await repo.setReminderEnabled(false);
    await repo.snoozeReminderUntil(until);
    final s = await status();
    expect(s.reminderEnabled, isFalse);
    expect(s.reminderSnoozedUntil, until);
  });

  test('folder: set, record, change, turn off', () async {
    await repo.setAutoBackupFolder(folder);
    expect((await status()).autoBackupFolder, folder);

    final at = DateTime.utc(2026, 9, 30, 8);
    await repo.recordAutoBackup(at, succeeded: true);
    var s = await status();
    expect(s.lastAutoBackupAt, at);
    expect(s.lastBackupAt, at, reason: 'an auto-backup is a backup');
    expect(s.autoBackupFailed, isFalse);

    // A failure is flagged but keeps the last good time.
    await repo.recordAutoBackup(
      at.add(const Duration(days: 7)),
      succeeded: false,
    );
    s = await status();
    expect(s.autoBackupFailed, isTrue);
    expect(s.lastAutoBackupAt, at);

    // A new folder clears the failure and is backed up on the next check.
    const other = BackupFolder(uri: 'content://tree/y', name: 'Other');
    await repo.setAutoBackupFolder(other);
    s = await status();
    expect(s.autoBackupFolder, other);
    expect(s.autoBackupFailed, isFalse);
    expect(s.lastAutoBackupAt, isNull);
    expect(s.lastBackupAt, at, reason: 'the last backup still happened');

    await repo.setAutoBackupFolder(null);
    s = await status();
    expect(s.autoBackupFolder, isNull);
    expect(s.autoBackupFailed, isFalse);
  });

  test('status stream updates on every change', () async {
    final stream = repo.watchStatus().map(
      (e) => e.getOrElse((f) => fail('$f')).reminderEnabled,
    );
    final expectation = expectLater(stream, emitsInOrder([true, false]));
    await Future<void>.delayed(Duration.zero);
    await repo.setReminderEnabled(false);
    await expectation;
  });

  test('password lives in secure storage, not the database', () async {
    await repo.setPassword('secret password');
    expect(
      (await repo.readPassword()).getOrElse((f) => fail('$f')),
      'secret password',
    );
    final settings = await db.select(db.settings).get();
    expect(settings.map((s) => s.value), isNot(contains('secret password')));
    await repo.setPassword(null);
    expect((await repo.readPassword()).getOrElse((f) => fail('$f')), isNull);
  });

  test('a malformed stored value falls back to the default', () async {
    await db
        .into(db.settings)
        .insert(
          SettingsCompanion.insert(
            key: 'backup_reminder_snoozed_until',
            value: 'soon',
          ),
        );
    expect((await status()).reminderSnoozedUntil, isNull);
  });
}
