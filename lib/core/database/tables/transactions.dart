import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/tables/accounts.dart';
import 'package:expense_tracker/core/database/tables/categories.dart';

/// Every money movement (PRD §6.2). Amounts are positive integer rupiah; the
/// [type] gives the direction.
@DataClassName('TransactionRow')
@TableIndex(name: 'idx_transactions_date', columns: {#date})
@TableIndex(
  name: 'idx_transactions_category_date',
  columns: {#categoryId, #date},
)
@TableIndex(name: 'idx_transactions_account_date', columns: {#accountId, #date})
@TableIndex(name: 'idx_transactions_type_date', columns: {#type, #date})
class Transactions extends Table {
  TextColumn get id => text()();

  /// `income` | `expense` | `transfer` | `adjustment`.
  TextColumn get type => text()();
  // Drift's documented CHECK syntax refers to the column itself.
  // ignore: recursive_getters
  IntColumn get amount => integer().check(amount.isBiggerThanValue(0))();
  TextColumn get accountId => text().references(Accounts, #id)();

  /// Transfers: the destination account. Adjustments: equals [accountId]
  /// when the adjustment adds money, null when it removes money (amounts
  /// are always positive).
  TextColumn get toAccountId => text().nullable().references(Accounts, #id)();

  /// Null for transfers and adjustments.
  TextColumn get categoryId => text().nullable().references(Categories, #id)();

  /// Local date, `YYYY-MM-DD`.
  TextColumn get date => text()();

  /// Local time, `HH:mm`.
  TextColumn get time => text()();
  TextColumn get note => text().nullable()();

  /// Rule that generated this row (table arrives in schema v2).
  TextColumn get recurringRuleId => text().nullable()();
  TextColumn get receiptPath => text().nullable()();

  /// UTC epoch milliseconds.
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
