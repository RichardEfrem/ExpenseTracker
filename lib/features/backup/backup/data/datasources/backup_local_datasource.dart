import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/database/watch_computed.dart';

typedef AllRows = ({
  List<AccountRow> accounts,
  List<CategoryRow> categories,
  List<TransactionRow> transactions,
  List<RecurringRuleRow> recurringRules,
  List<PendingOccurrenceRow> pendingOccurrences,
  List<TagRow> tags,
  List<TransactionTagRow> transactionTags,
  List<SettingRow> settings,
});

/// Whole-database reads and writes for backup, restore and erase. Every
/// write is one DB transaction, so a failure leaves the data untouched.
class BackupLocalDataSource {
  const BackupLocalDataSource(this._db);

  final AppDatabase _db;

  Future<AllRows> readAll() => _db.transaction(
    () async => (
      accounts: await _db.select(_db.accounts).get(),
      categories: await _db.select(_db.categories).get(),
      transactions: await _db.select(_db.transactions).get(),
      recurringRules: await _db.select(_db.recurringRules).get(),
      pendingOccurrences: await _db.select(_db.pendingOccurrences).get(),
      tags: await _db.select(_db.tags).get(),
      transactionTags: await _db.select(_db.transactionTags).get(),
      settings: await _db.select(_db.settings).get(),
    ),
  );

  /// Children before parents, so no foreign key is ever left dangling.
  Future<void> _deleteAll() async {
    await _db.delete(_db.transactionTags).go();
    await _db.delete(_db.tags).go();
    await _db.delete(_db.pendingOccurrences).go();
    await _db.delete(_db.recurringRules).go();
    await _db.delete(_db.transactions).go();
    await _db.delete(_db.categories).go();
    await _db.delete(_db.accounts).go();
    await _db.delete(_db.settings).go();
  }

  /// Parents before children.
  Future<void> _insertAll(AllRows rows, InsertMode mode) => _db.batch((b) {
    b
      ..insertAll(_db.accounts, rows.accounts, mode: mode)
      ..insertAll(_db.categories, rows.categories, mode: mode)
      ..insertAll(_db.recurringRules, rows.recurringRules, mode: mode)
      ..insertAll(_db.transactions, rows.transactions, mode: mode)
      ..insertAll(_db.pendingOccurrences, rows.pendingOccurrences, mode: mode)
      ..insertAll(_db.tags, rows.tags, mode: mode)
      ..insertAll(_db.transactionTags, rows.transactionTags, mode: mode)
      ..insertAll(_db.settings, rows.settings, mode: mode);
  });

  /// Deletes everything, then inserts [rows].
  Future<void> replaceAll(AllRows rows) => _db.transaction(() async {
    await _deleteAll();
    await _insertAll(rows, InsertMode.insert);
  });

  /// Inserts rows whose id (settings: key) is new; existing rows win. Tag
  /// names are unique, so a backup tag whose name is already here becomes
  /// that tag; a transaction already here keeps its own tags.
  Future<void> mergeAll(AllRows rows) => _db.transaction(() async {
    final tagIdByName = {
      for (final t in await _db.select(_db.tags).get()) t.name: t.id,
    };
    final tagIds = {
      for (final t in rows.tags) t.id: tagIdByName[t.name] ?? t.id,
    };
    final existing =
        (await (_db.selectOnly(_db.transactions)
                  ..addColumns([_db.transactions.id]))
                .map((r) => r.read(_db.transactions.id)!)
                .get())
            .toSet();
    await _insertAll((
      accounts: rows.accounts,
      categories: rows.categories,
      transactions: rows.transactions,
      recurringRules: rows.recurringRules,
      pendingOccurrences: rows.pendingOccurrences,
      tags: [
        for (final t in rows.tags)
          if (!tagIdByName.containsKey(t.name)) t,
      ],
      transactionTags: [
        for (final l in rows.transactionTags)
          if (!existing.contains(l.transactionId))
            TransactionTagRow(
              transactionId: l.transactionId,
              tagId: tagIds[l.tagId] ?? l.tagId,
            ),
      ],
      settings: rows.settings,
    ), InsertMode.insertOrIgnore);
  });

  /// Deletes everything and seeds the fresh-install defaults.
  Future<void> eraseAll() => _db.transaction(() async {
    await _deleteAll();
    await seedDefaults(_db, clock: _db.clock, ids: _db.ids);
  });

  Future<void> putSetting(String key, String value) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));

  Future<void> deleteSettings(Iterable<String> keys) =>
      (_db.delete(_db.settings)..where((s) => s.key.isIn(keys))).go();

  /// Several settings in one DB transaction.
  Future<void> putSettings(Map<String, String> values) => _db.transaction(
    () => _db.batch(
      (b) => b.insertAllOnConflictUpdate(_db.settings, [
        for (final MapEntry(:key, :value) in values.entries)
          SettingsCompanion.insert(key: key, value: value),
      ]),
    ),
  );

  /// Settings rows and the oldest transaction's `created_at`, for the
  /// backup status.
  Future<({Map<String, String> settings, int? firstRecordMs})>
  readStatusRows() => _db.transaction(() async {
    final settings = await _db.select(_db.settings).get();
    final min = _db.transactions.createdAt.min();
    final first = await (_db.selectOnly(
      _db.transactions,
    )..addColumns([min])).getSingle();
    return (
      settings: {for (final r in settings) r.key: r.value},
      firstRecordMs: first.read(min),
    );
  });

  Stream<({Map<String, String> settings, int? firstRecordMs})>
  watchStatusRows() =>
      watchComputed(_db, [_db.settings, _db.transactions], readStatusRows);
}
