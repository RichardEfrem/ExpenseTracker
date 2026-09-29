import 'package:expense_tracker/core/database/app_database.dart';

/// Key/value access to the `settings` table.
class SettingsLocalDataSource {
  const SettingsLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<Map<String, String>> watchAll() => _db
      .select(_db.settings)
      .watch()
      .map((rows) => {for (final row in rows) row.key: row.value});

  Future<void> put(String key, String value) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));
}
