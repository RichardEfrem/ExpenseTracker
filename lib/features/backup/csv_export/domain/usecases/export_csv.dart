import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/repositories/csv_export_repository.dart';
import 'package:fpdart/fpdart.dart';

/// How a CSV export ended.
sealed class CsvExportResult {
  const CsvExportResult();
}

/// Nothing to export in the range; no file was made.
final class CsvExportEmpty extends CsvExportResult {
  const CsvExportEmpty();
}

final class CsvExportCancelled extends CsvExportResult {
  const CsvExportCancelled();
}

final class CsvExported extends CsvExportResult {
  const CsvExported(this.count);

  final int count;
}

/// Exports the transactions in a date range as CSV to the share sheet or a
/// folder (PRD BAK-06).
class ExportCsv {
  const ExportCsv(this._repository);

  final CsvExportRepository _repository;

  /// `expense-tracker-2026-01-01-to-2026-09-30.csv`, or
  /// `expense-tracker-all.csv` for everything.
  static String fileNameFor(Period? range) => range == null
      ? 'expense-tracker-all.csv'
      : 'expense-tracker-${range.start.toIso()}-to-${range.end.toIso()}.csv';

  Future<Either<Failure, CsvExportResult>> call(
    Period? range,
    ExportTarget target,
  ) async {
    final rows = await _repository.rows(range);
    return rows.match((failure) async => Left(failure), (rows) async {
      if (rows.isEmpty) return const Right(CsvExportEmpty());
      final encoded = _repository.encode(rows);
      return encoded.match((failure) async => Left(failure), (csv) async {
        final delivered = await _repository.deliver(
          csv,
          fileNameFor(range),
          target,
        );
        return delivered.map(
          (delivered) =>
              delivered ? CsvExported(rows.length) : const CsvExportCancelled(),
        );
      });
    });
  }
}
