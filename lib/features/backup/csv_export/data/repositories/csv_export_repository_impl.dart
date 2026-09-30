import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/csv.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/data/datasources/csv_export_local_datasource.dart';
import 'package:expense_tracker/features/backup/csv_export/data/models/csv_transaction_row_model.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/entities/csv_transaction_row.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/repositories/csv_export_repository.dart';
import 'package:expense_tracker/features/transactions/transactions_data.dart';
import 'package:fpdart/fpdart.dart';

class CsvExportRepositoryImpl implements CsvExportRepository {
  const CsvExportRepositoryImpl(this._local, this._files);

  final CsvExportLocalDataSource _local;
  final BackupFileDataSource _files;

  static CsvTransactionRow _toEntity(CsvSourceRow r) {
    final type = TransactionType.values.byName(r.type);
    final isAdjustment = type == TransactionType.adjustment;
    return CsvTransactionRow(
      date: LocalDate.parse(r.date),
      time: LocalTime.parse(r.time),
      type: type,
      // An adjustment with no target account removes money (see the
      // transactions table).
      amount: isAdjustment && r.toAccountId == null ? -r.amount : r.amount,
      category: r.category,
      account: r.account,
      toAccount: type == TransactionType.transfer ? r.toAccount : null,
      note: r.note,
      tags: r.tags == null ? const [] : r.tags!.split(', '),
    );
  }

  @override
  Future<Either<Failure, List<CsvTransactionRow>>> rows(Period? range) =>
      guard(() async {
        final rows = await _local.rows(from: range?.start, to: range?.end);
        return [for (final r in rows) _toEntity(r)];
      });

  @override
  Either<Failure, String> encode(List<CsvTransactionRow> rows) => guardSync(
    () => Csv.encode([csvHeader, for (final r in rows) r.toCsvFields()]),
  );

  @override
  Future<Either<Failure, bool>> deliver(
    String contents,
    String fileName,
    ExportTarget target,
  ) => guard(
    () => switch (target) {
      ExportTarget.share => _files.share(
        contents,
        fileName,
        mimeType: BackupFileDataSource.csvMimeType,
      ),
      ExportTarget.saveToDevice => _files.save(
        contents,
        fileName,
        mimeType: BackupFileDataSource.csvMimeType,
      ),
    },
  );
}
