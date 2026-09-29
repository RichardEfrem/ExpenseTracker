import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/accounts/accounts_data.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';

/// A transaction row with its category and accounts, as one SQL join.
typedef JoinedTransactionRow = ({
  TransactionRow transaction,
  CategoryRow? category,
  AccountRow account,
  AccountRow? toAccount,
});

DateTime _utc(int ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);

extension TransactionRowMapper on TransactionRow {
  Transaction toEntity() => Transaction(
    id: id,
    type: TransactionType.values.byName(type),
    amount: amount,
    accountId: accountId,
    toAccountId: toAccountId,
    categoryId: categoryId,
    date: LocalDate.parse(date),
    time: LocalTime.parse(time),
    note: note,
    recurringRuleId: recurringRuleId,
    receiptPath: receiptPath,
    createdAt: _utc(createdAt),
    updatedAt: _utc(updatedAt),
  );
}

extension JoinedTransactionMapper on JoinedTransactionRow {
  TransactionView toView() => TransactionView(
    transaction: transaction.toEntity(),
    category: category?.toEntity(),
    account: account.toEntity(),
    toAccount: toAccount?.toEntity(),
  );
}

extension TransactionInputJson on TransactionInput {
  /// The write payload, keyed by `transactions` column. Every key is always
  /// present: an explicit null clears the column on update (e.g. a removed
  /// note, or the destination account when a transfer becomes an expense).
  Map<String, Object?> toJson() => {
    'type': type.name,
    'amount': amount,
    'account_id': accountId,
    'to_account_id': toAccountId,
    'category_id': categoryId,
    'date': date.toIso(),
    'time': time.format(),
    'note': note,
  };
}

extension TransactionRowJson on Transaction {
  /// Every column, for restoring a deleted row exactly (undo).
  Map<String, Object?> toRowJson() => {
    'id': id,
    'type': type.name,
    'amount': amount,
    'account_id': accountId,
    'to_account_id': toAccountId,
    'category_id': categoryId,
    'date': date.toIso(),
    'time': time.format(),
    'note': note,
    'recurring_rule_id': recurringRuleId,
    'receipt_path': receiptPath,
    'created_at': createdAt.millisecondsSinceEpoch,
    'updated_at': updatedAt.millisecondsSinceEpoch,
  };
}
