import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/export_backup.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements BackupRepository {}

void main() {
  late _MockRepository repo;
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
    when(
      () => repo.snapshot(appVersion: any(named: 'appVersion')),
    ).thenAnswer((_) async => Right(file));
    when(() => repo.encode(any())).thenReturn(const Right('{}'));
    when(
      () => repo.recordBackup(any()),
    ).thenAnswer((_) async => const Right(unit));
  });

  ExportBackup exporter() => ExportBackup(repo, FixedClock(now));

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
}
