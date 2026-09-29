import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';

typedef AllRows = ({
  List<AccountRow> accounts,
  List<CategoryRow> categories,
  List<TransactionRow> transactions,
  List<RecurringRuleRow> recurringRules,
  List<PendingOccurrenceRow> pendingOccurrences,
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
      settings: await _db.select(_db.settings).get(),
    ),
  );

  /// Children before parents, so no foreign key is ever left dangling.
  Future<void> _deleteAll() async {
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
      ..insertAll(_db.settings, rows.settings, mode: mode);
  });

  /// Deletes everything, then inserts [rows].
  Future<void> replaceAll(AllRows rows) => _db.transaction(() async {
    await _deleteAll();
    await _insertAll(rows, InsertMode.insert);
  });

  /// Inserts rows whose id (settings: key) is new; existing rows win.
  Future<void> mergeAll(AllRows rows) =>
      _db.transaction(() => _insertAll(rows, InsertMode.insertOrIgnore));

  /// Deletes everything and seeds the fresh-install defaults.
  Future<void> eraseAll() => _db.transaction(() async {
    await _deleteAll();
    await seedDefaults(_db, clock: _db.clock, ids: _db.ids);
  });

  Future<void> putSetting(String key, String value) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));
}
