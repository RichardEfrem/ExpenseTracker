import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/raw_values.dart';
import 'package:expense_tracker/features/transactions/transaction/data/models/transaction_model.dart';

/// SQL for single transactions, and this slice's keys in `settings`.
class TransactionLocalDataSource {
  TransactionLocalDataSource(this._db);

  final AppDatabase _db;
  late final _toAccount = _db.alias(_db.accounts, 'to_account');

  Future<T> transaction<T>(Future<T> Function() action) =>
      _db.transaction(action);

  Future<void> insert(Map<String, Object?> json) =>
      _db.into(_db.transactions).insert(rawValues(json));

  Future<int> update(String id, Map<String, Object?> json) => (_db.update(
    _db.transactions,
  )..where((t) => t.id.equals(id))).write(rawValues(json));

  Future<TransactionRow?> findById(String id) => (_db.select(
    _db.transactions,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> delete(String id) =>
      (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();

  /// Transactions joined with their category and accounts. Shared by the
  /// slices that list transactions.
  JoinedSelectStatement<HasResultSet, dynamic> joined() {
    final toAccount = _toAccount;
    return _db.select(_db.transactions).join([
      leftOuterJoin(
        _db.categories,
        _db.categories.id.equalsExp(_db.transactions.categoryId),
      ),
      innerJoin(
        _db.accounts,
        _db.accounts.id.equalsExp(_db.transactions.accountId),
      ),
      leftOuterJoin(
        toAccount,
        toAccount.id.equalsExp(_db.transactions.toAccountId),
      ),
    ]);
  }

  JoinedTransactionRow readJoined(TypedResult row) => (
    transaction: row.readTable(_db.transactions),
    category: row.readTableOrNull(_db.categories),
    account: row.readTable(_db.accounts),
    toAccount: row.readTableOrNull(_toAccount),
  );

  /// Newest first: by date, then time, then creation.
  List<OrderingTerm> get newestFirst => [
    OrderingTerm.desc(_db.transactions.date),
    OrderingTerm.desc(_db.transactions.time),
    OrderingTerm.desc(_db.transactions.createdAt),
  ];

  Stream<JoinedTransactionRow?> watchJoined(String id) {
    final query = joined()..where(_db.transactions.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row == null ? null : readJoined(row),
    );
  }

  Stream<List<JoinedTransactionRow>> watchRecent(int limit) {
    final query = joined()
      ..orderBy(newestFirst)
      ..limit(limit);
    return query.watch().map((rows) => rows.map(readJoined).toList());
  }

  Future<String?> getSetting(String key) async => (await (_db.select(
    _db.settings,
  )..where((s) => s.key.equals(key))).getSingleOrNull())?.value;

  Future<void> putSetting(String key, String? value) => value == null
      ? (_db.delete(_db.settings)..where((s) => s.key.equals(key))).go()
      : _db
            .into(_db.settings)
            .insertOnConflictUpdate(
              SettingsCompanion.insert(key: key, value: value),
            );
}
