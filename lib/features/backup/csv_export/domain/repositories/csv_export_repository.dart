import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/entities/csv_transaction_row.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CsvExportRepository {
  /// Transactions in [range] (all of them when null), oldest first.
  Future<Either<Failure, List<CsvTransactionRow>>> rows(Period? range);

  /// The CSV file: a header line, then one line per row.
  Either<Failure, String> encode(List<CsvTransactionRow> rows);

  /// True when delivered, false when the user cancelled.
  Future<Either<Failure, bool>> deliver(
    String contents,
    String fileName,
    ExportTarget target,
  );
}
