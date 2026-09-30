import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/balance_sql.dart';
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

  /// Account id → current balance for each of [accountIds]: opening balance
  /// plus every recorded movement, future-dated ones included.
  Future<Map<String, int>> balancesOf(Set<String> accountIds) async {
    if (accountIds.isEmpty) return {};
    final placeholders = List.filled(accountIds.length, '?').join(', ');
    final rows = await _db
        .customSelect(
          '$balanceMovesCte SELECT a.id, a.opening_balance + COALESCE('
          '(SELECT SUM(delta) FROM moves WHERE acct = a.id), 0) AS balance '
          'FROM accounts a WHERE a.id IN ($placeholders)',
          variables: [for (final id in accountIds) Variable<String>(id)],
          readsFrom: {_db.accounts, _db.transactions},
        )
        .get();
    return {for (final r in rows) r.read<String>('id'): r.read<int>('balance')};
  }

  /// The transaction's tag names, sorted.
  Future<List<String>> tagsOf(String id) async {
    final rows = await _db
        .customSelect(
          'SELECT g.name FROM transaction_tags tt '
          'JOIN tags g ON g.id = tt.tag_id '
          'WHERE tt.transaction_id = ? ORDER BY g.name',
          variables: [Variable<String>(id)],
          readsFrom: {_db.tags, _db.transactionTags},
        )
        .get();
    return [for (final r in rows) r.read<String>('name')];
  }

  /// Makes [names] (already normalized) the transaction's tags: creates the
  /// tags that don't exist yet, then drops tags nothing uses any more. Call
  /// inside a DB transaction.
  Future<void> setTags(
    String id,
    List<String> names, {
    required String Function() newId,
    required int nowMs,
  }) async {
    await (_db.delete(
      _db.transactionTags,
    )..where((l) => l.transactionId.equals(id))).go();
    for (final name in names) {
      await _db
          .into(_db.tags)
          .insert(
            TagsCompanion.insert(id: newId(), name: name, createdAt: nowMs),
            mode: InsertMode.insertOrIgnore,
          );
      final tag = await (_db.select(
        _db.tags,
      )..where((g) => g.name.equals(name))).getSingle();
      await _db
          .into(_db.transactionTags)
          .insert(
            TransactionTagsCompanion.insert(transactionId: id, tagId: tag.id),
          );
    }
    await pruneTags();
  }

  /// Deletes tags no transaction uses.
  Future<void> pruneTags() => _db.customStatement(
    'DELETE FROM tags WHERE id NOT IN (SELECT tag_id FROM transaction_tags)',
  );

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
