import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'csv_transaction_row.freezed.dart';

/// One transaction as a CSV line (PRD BAK-06), with names instead of ids.
@freezed
abstract class CsvTransactionRow with _$CsvTransactionRow {
  const factory CsvTransactionRow({
    required LocalDate date,
    required LocalTime time,
    required TransactionType type,

    /// Rupiah. Positive, with [type] giving the direction, except for
    /// adjustments that remove money, which are negative.
    required int amount,

    /// Null for transfers and adjustments.
    String? category,
    required String account,

    /// Transfers only: where the money went.
    String? toAccount,
    String? note,

    /// Tag names, sorted.
    @Default(<String>[]) List<String> tags,
  }) = _CsvTransactionRow;
}
