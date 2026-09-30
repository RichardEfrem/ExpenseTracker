import 'package:expense_tracker/core/utils/csv.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/entities/csv_transaction_row.dart';

/// Column names of the exported CSV, in order (PRD BAK-06). A file-format
/// contract, not user-facing text, so English and snake_case like the
/// backup JSON.
const csvHeader = [
  'date',
  'time',
  'type',
  'amount',
  'category',
  'account',
  'to_account',
  'note',
  'tags',
];

extension CsvTransactionRowCsv on CsvTransactionRow {
  /// The row's fields in [csvHeader] order: ISO date, `HH:mm`, the type's
  /// name, plain integer rupiah (no grouping, so spreadsheets read a
  /// number), and empty strings for missing values. Typed text is guarded
  /// against formula injection. Tags are one field, `a, b` (tag names
  /// never contain commas).
  List<String> toCsvFields() => [
    date.toIso(),
    time.format(),
    type.name,
    '$amount',
    Csv.text(category ?? ''),
    Csv.text(account),
    Csv.text(toAccount ?? ''),
    Csv.text(note ?? ''),
    Csv.text(tags.join(', ')),
  ];
}
