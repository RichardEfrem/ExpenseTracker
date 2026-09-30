import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/auto_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/encode_backup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements BackupRepository {}

class _MockSettings extends Mock implements BackupSettingsRepository {}

void main() {
  late _MockRepository repo;
  late _MockSettings settings;
  final now = DateTime(2026, 9, 30, 8);
  const folder = BackupFolder(uri: 'content://tree/x', name: 'Backups');
  final file = BackupFile(
    schemaVersion: 2,
    appVersion: 'v',
    exportedAt: now,
    accounts: const [],
    categories: const [],
    transactions: const [],
    settings: const {},
  );

  setUpAll(() {
    registerFallbackValue(folder);
    registerFallbackValue(file);
    registerFallbackValue(DateTime(2000));
  });

  setUp(() {
    repo = _MockRepository();
    settings = _MockSettings();
    when(
      () => repo.snapshot(appVersion: any(named: 'appVersion')),
    ).thenAnswer((_) async => Right(file));
    when(() => repo.encode(any())).thenReturn(const Right('{}'));
    when(settings.readPassword).thenAnswer((_) async => const Right(null));
    when(
      () =>
          settings.recordAutoBackup(any(), succeeded: any(named: 'succeeded')),
    ).thenAnswer((_) async => const Right(unit));
    when(
      () => repo.releaseFolder(any()),
    ).thenAnswer((_) async => const Right(unit));
  });

  void givenStatus(BackupStatus status) =>
      when(settings.getStatus).thenAnswer((_) async => Right(status));

  RunAutoBackup runner() => RunAutoBackup(
    repo,
    settings,
    EncodeBackup(repo, settings),
    FixedClock(now),
  );

  group('RunAutoBackup', () {
    test('no folder: nothing happens', () async {
      givenStatus(const BackupStatus());
      expect(
        await runner()(appVersion: 'v'),
        const Right<Failure, AutoBackupOutcome>(AutoBackupOutcome.notDue),
      );
      verifyNever(() => repo.writeToFolder(any(), any(), any()));
    });

    test('backed up 3 days ago: not due', () async {
      givenStatus(
        BackupStatus(
          autoBackupFolder: folder,
          lastAutoBackupAt: now.subtract(const Duration(days: 3)),
        ),
      );
      expect(
        (await runner()(appVersion: 'v')).toNullable(),
        AutoBackupOutcome.notDue,
      );
      verifyNever(() => repo.writeToFolder(any(), any(), any()));
    });

    test('due: writes a dated file and records success', () async {
      givenStatus(const BackupStatus(autoBackupFolder: folder));
      when(
        () => repo.writeToFolder(any(), any(), any()),
      ).thenAnswer((_) async => const Right(unit));
      expect(
        (await runner()(appVersion: 'v')).toNullable(),
        AutoBackupOutcome.written,
      );
      verify(
        () => repo.writeToFolder(
          folder,
          'expense-tracker-backup-2026-09-30.json',
          '{}',
        ),
      ).called(1);
      verify(() => settings.recordAutoBackup(now, succeeded: true)).called(1);
    });

    test('write fails (access revoked): recorded as failed', () async {
      givenStatus(const BackupStatus(autoBackupFolder: folder));
      when(
        () => repo.writeToFolder(any(), any(), any()),
      ).thenAnswer((_) async => const Left(Failure.file('revoked')));
      expect(
        (await runner()(appVersion: 'v')).toNullable(),
        AutoBackupOutcome.failed,
      );
      verify(() => settings.recordAutoBackup(now, succeeded: false)).called(1);
    });

    test('encrypts when a password is set', () async {
      givenStatus(const BackupStatus(autoBackupFolder: folder));
      when(
        settings.readPassword,
      ).thenAnswer((_) async => const Right('password1'));
      when(
        () => repo.encrypt('{}', 'password1'),
      ).thenAnswer((_) async => const Right('sealed'));
      when(
        () => repo.writeToFolder(any(), any(), any()),
      ).thenAnswer((_) async => const Right(unit));
      await runner()(appVersion: 'v');
      verify(() => repo.writeToFolder(folder, any(), 'sealed')).called(1);
    });
  });

  group('ChooseAutoBackupFolder', () {
    test('cancelled picker changes nothing', () async {
      when(repo.pickFolder).thenAnswer((_) async => const Right(null));
      expect(
        await ChooseAutoBackupFolder(repo, settings)(),
        const Right<Failure, bool>(false),
      );
      verifyNever(() => settings.setAutoBackupFolder(any()));
    });

    test('a new folder replaces and releases the old one', () async {
      const newer = BackupFolder(uri: 'content://tree/y', name: 'New');
      givenStatus(const BackupStatus(autoBackupFolder: folder));
      when(repo.pickFolder).thenAnswer((_) async => const Right(newer));
      when(
        () => settings.setAutoBackupFolder(any()),
      ).thenAnswer((_) async => const Right(unit));
      expect(
        await ChooseAutoBackupFolder(repo, settings)(),
        const Right<Failure, bool>(true),
      );
      verify(() => repo.releaseFolder(folder)).called(1);
      verify(() => settings.setAutoBackupFolder(newer)).called(1);
    });
  });

  test('TurnOffAutoBackup releases the folder and clears it', () async {
    givenStatus(const BackupStatus(autoBackupFolder: folder));
    when(
      () => settings.setAutoBackupFolder(null),
    ).thenAnswer((_) async => const Right(unit));
    await TurnOffAutoBackup(repo, settings)();
    verify(() => repo.releaseFolder(folder)).called(1);
    verify(() => settings.setAutoBackupFolder(null)).called(1);
  });
}
