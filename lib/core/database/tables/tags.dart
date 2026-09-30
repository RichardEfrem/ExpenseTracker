import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/tables/transactions.dart';

/// Free-form labels across categories, e.g. `trip-bali` (PRD US-15). Added
/// in schema v3. Names are stored normalized (lowercase, no spaces), so
/// the unique key is case-insensitive in practice.
@DataClassName('TagRow')
class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();

  /// UTC epoch milliseconds.
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Which transactions carry which tags. Rows go with their transaction or
/// tag. Added in schema v3.
@DataClassName('TransactionTagRow')
@TableIndex(name: 'idx_transaction_tags_tag', columns: {#tagId})
class TransactionTags extends Table {
  TextColumn get transactionId =>
      text().references(Transactions, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {transactionId, tagId};
}
