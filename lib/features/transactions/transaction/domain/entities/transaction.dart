import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

/// Direction of a transaction. Transfers and adjustments move or correct
/// balances and never count as income or expense (PRD ACC-04, ACC-05).
enum TransactionType {
  expense,
  income,
  transfer,
  adjustment;

  bool get needsCategory => this == expense || this == income;
}

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required TransactionType type,

    /// Positive integer rupiah; [type] gives the direction.
    required int amount,
    required String accountId,
    String? toAccountId,
    String? categoryId,
    required LocalDate date,
    required LocalTime time,
    String? note,
    String? recurringRuleId,
    String? receiptPath,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Transaction;

  const Transaction._();

  /// Effect on [accountId]'s balance for an adjustment: positive when
  /// [toAccountId] is set (money in), negative otherwise (amounts are
  /// always stored positive). Other types return [amount].
  int get signedAmount => type == TransactionType.adjustment
      ? (toAccountId == null ? -amount : amount)
      : amount;
}
