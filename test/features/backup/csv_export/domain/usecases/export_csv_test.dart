import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/entities/csv_transaction_row.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/repositories/csv_export_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/usecases/export_csv.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements CsvExportRepository {}

void main() {
  late _MockRepository repo;
  final row = CsvTransactionRow(
    date: LocalDate(2026, 9, 1),
    time: LocalTime.parse('08:00'),
    type: TransactionType.expense,
    amount: 1000,
    account: 'Cash',
  );
  final range = Period.custom(LocalDate(2026, 1, 1), LocalDate(2026, 9, 30));

  setUpAll(() => registerFallbackValue(ExportTarget.share));

  setUp(() {
    repo = _MockRepository();
    when(() => repo.encode(any())).thenReturn(const Right('csv'));
  });

  test('delivers a file named after the range and counts rows', () async {
    when(() => repo.rows(range)).thenAnswer((_) async => Right([row, row]));
    when(
      () => repo.deliver(any(), any(), any()),
    ).thenAnswer((_) async => const Right(true));
    final result = await ExportCsv(repo)(range, ExportTarget.saveToDevice);
    expect((result.getOrElse((f) => fail('$f')) as CsvExported).count, 2);
    verify(
      () => repo.deliver(
        'csv',
        'expense-tracker-2026-01-01-to-2026-09-30.csv',
        ExportTarget.saveToDevice,
      ),
    ).called(1);
  });

  test('an empty range makes no file', () async {
    when(() => repo.rows(null)).thenAnswer((_) async => const Right([]));
    final result = await ExportCsv(repo)(null, ExportTarget.share);
    expect(result.getOrElse((f) => fail('$f')), isA<CsvExportEmpty>());
    verifyNever(() => repo.deliver(any(), any(), any()));
  });

  test('cancelled share sheet', () async {
    when(() => repo.rows(null)).thenAnswer((_) async => Right([row]));
    when(
      () => repo.deliver(any(), any(), any()),
    ).thenAnswer((_) async => const Right(false));
    final result = await ExportCsv(repo)(null, ExportTarget.share);
    expect(result.getOrElse((f) => fail('$f')), isA<CsvExportCancelled>());
  });

  test('a query failure stops before delivering', () async {
    when(
      () => repo.rows(null),
    ).thenAnswer((_) async => const Left(Failure.database()));
    expect((await ExportCsv(repo)(null, ExportTarget.share)).isLeft(), isTrue);
    verifyNever(() => repo.deliver(any(), any(), any()));
  });

  test('all-time file name', () {
    expect(ExportCsv.fileNameFor(null), 'expense-tracker-all.csv');
  });
}
