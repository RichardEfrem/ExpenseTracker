import 'package:expense_tracker/core/database/app_database.dart';

/// Tags with their usage counts.
class TagLocalDataSource {
  const TagLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<({String id, String name, int createdAt, int usage})>>
  watchAll() => _db
      .customSelect(
        'SELECT g.id, g.name, g.created_at, COUNT(tt.transaction_id) AS usage '
        'FROM tags g LEFT JOIN transaction_tags tt ON tt.tag_id = g.id '
        'GROUP BY g.id ORDER BY usage DESC, g.name',
        readsFrom: {_db.tags, _db.transactionTags},
      )
      .watch()
      .map(
        (rows) => [
          for (final r in rows)
            (
              id: r.read<String>('id'),
              name: r.read<String>('name'),
              createdAt: r.read<int>('created_at'),
              usage: r.read<int>('usage'),
            ),
        ],
      );
}
