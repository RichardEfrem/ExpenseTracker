import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/picked_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/encode_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/export_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/preview_backup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements BackupRepository {}

class _MockSettings extends Mock implements BackupSettingsRepository {}

void main() {
  late _MockRepository repo;
  late _MockSettings settings;
  final now = DateTime(2026, 9, 29, 21, 4);
  final file = BackupFile(
    schemaVersion: 1,
    appVersion: 'v',
    exportedAt: now,
    accounts: const [],
    categories: const [],
    transactions: const [],
    settings: const {},
  );

  setUpAll(() {
    registerFallbackValue(file);
    registerFallbackValue(ExportTarget.share);
    registerFallbackValue(DateTime(2000));
  });

  setUp(() {
    repo = _MockRepository();
    settings = _MockSettings();
    when(
      () => repo.snapshot(appVersion: any(named: 'appVersion')),
    ).thenAnswer((_) async => Right(file));
    when(() => repo.encode(any())).thenReturn(const Right('{}'));
    when(
      () => repo.recordBackup(any()),
    ).thenAnswer((_) async => const Right(unit));
    when(settings.readPassword).thenAnswer((_) async => const Right(null));
  });

  ExportBackup exporter() =>
      ExportBackup(repo, EncodeBackup(repo, settings), FixedClock(now));

  test('delivers a dated file and records the backup time', () async {
    when(
      () => repo.deliver(any(), any(), any()),
    ).thenAnswer((_) async => const Right(true));
    final result = await exporter()(
      appVersion: 'v',
      target: ExportTarget.share,
    );
    expect(result, const Right<Failure, bool>(true));
    verify(
      () => repo.deliver(
        '{}',
        'expense-tracker-backup-2026-09-29.json',
        ExportTarget.share,
      ),
    ).called(1);
    verify(() => repo.recordBackup(now)).called(1);
    verifyNever(() => repo.encrypt(any(), any()));
  });

  test('with a backup password, the encrypted file is delivered', () async {
    when(
      settings.readPassword,
    ).thenAnswer((_) async => const Right('pass1234'));
    when(
      () => repo.encrypt('{}', 'pass1234'),
    ).thenAnswer((_) async => const Right('sealed'));
    when(
      () => repo.deliver(any(), any(), any()),
    ).thenAnswer((_) async => const Right(true));
    await exporter()(appVersion: 'v', target: ExportTarget.share);
    verify(() => repo.deliver('sealed', any(), ExportTarget.share)).called(1);
  });

  test('cancelled share records nothing', () async {
    when(
      () => repo.deliver(any(), any(), any()),
    ).thenAnswer((_) async => const Right(false));
    expect(
      await exporter()(appVersion: 'v', target: ExportTarget.saveToDevice),
      const Right<Failure, bool>(false),
    );
    verifyNever(() => repo.recordBackup(any()));
  });

  test('a failure stops the chain', () async {
    when(
      () => repo.snapshot(appVersion: any(named: 'appVersion')),
    ).thenAnswer((_) async => const Left(Failure.database()));
    expect(
      (await exporter()(appVersion: 'v', target: ExportTarget.share)).isLeft(),
      isTrue,
    );
    verifyNever(() => repo.deliver(any(), any(), any()));
  });

  test('file name uses the local date', () {
    expect(
      ExportBackup.fileNameFor(LocalDate(2026, 1, 5)),
      'expense-tracker-backup-2026-01-05.json',
    );
  });

  group('PreviewBackup', () {
    test('an encrypted file comes back locked, unread', () async {
      when(repo.pickFile).thenAnswer((_) async => const Right('sealed'));
      when(() => repo.isEncrypted('sealed')).thenReturn(true);
      final picked = (await PreviewBackup(repo)()).toNullable();
      expect((picked! as LockedBackup).contents, 'sealed');
      verifyNever(() => repo.decode(any()));
    });

    test('a plain file is decoded', () async {
      when(repo.pickFile).thenAnswer((_) async => const Right('{}'));
      when(() => repo.isEncrypted('{}')).thenReturn(false);
      when(() => repo.decode('{}')).thenReturn(Right(file));
      final picked = (await PreviewBackup(repo)()).toNullable();
      expect((picked! as ReadableBackup).file, file);
    });

    test('UnlockBackup decrypts, then decodes', () async {
      when(
        () => repo.decrypt('sealed', 'pw'),
      ).thenAnswer((_) async => const Right('{}'));
      when(() => repo.decode('{}')).thenReturn(Right(file));
      expect(
        await UnlockBackup(repo)(const LockedBackup('sealed'), 'pw'),
        Right<Failure, BackupFile>(file),
      );
    });
  });
}
