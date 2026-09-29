import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/raw_values.dart';

/// SQL for the `categories` table and category usage in `transactions`.
class CategoryLocalDataSource {
  const CategoryLocalDataSource(this._db);

  final AppDatabase _db;

  /// Runs [action] in one DB transaction: all of it or none of it.
  Future<T> transaction<T>(Future<T> Function() action) =>
      _db.transaction(action);

  Stream<List<CategoryRow>> watchAll({
    String? type,
    bool includeArchived = false,
  }) {
    final query = _db.select(_db.categories)
      ..where(
        (c) => Expression.and([
          if (type != null) c.type.equals(type),
          if (!includeArchived) c.isArchived.equals(false),
        ]),
      )
      ..orderBy([
        (c) => OrderingTerm.asc(c.isArchived),
        (c) => OrderingTerm.asc(c.sortOrder),
        (c) => OrderingTerm.asc(c.name),
      ]);
    return query.watch();
  }

  Stream<Map<String, int>> watchUsageCounts() {
    final count = _db.transactions.id.count();
    final query = _db.selectOnly(_db.transactions)
      ..addColumns([_db.transactions.categoryId, count])
      ..where(_db.transactions.categoryId.isNotNull())
      ..groupBy([_db.transactions.categoryId]);
    return query.watch().map(
      (rows) => {
        for (final row in rows)
          row.read(_db.transactions.categoryId)!: row.read(count)!,
      },
    );
  }

  Future<CategoryRow?> findById(String id) => (_db.select(
    _db.categories,
  )..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<int> nextSortOrder(String type) async {
    final max = _db.categories.sortOrder.max();
    final row =
        await (_db.selectOnly(_db.categories)
              ..addColumns([max])
              ..where(_db.categories.type.equals(type)))
            .getSingle();
    return (row.read(max) ?? -1) + 1;
  }

  Future<void> insert(Map<String, Object?> json) =>
      _db.into(_db.categories).insert(rawValues(json));

  /// Returns the number of rows changed (0 when [id] does not exist).
  Future<int> update(String id, Map<String, Object?> json) => (_db.update(
    _db.categories,
  )..where((c) => c.id.equals(id))).write(rawValues(json));

  /// Transactions and recurring rules that use the category.
  Future<int> countUsage(String id) async {
    final row = await _db
        .customSelect(
          'SELECT (SELECT COUNT(*) FROM transactions WHERE category_id = ?1) + '
          '(SELECT COUNT(*) FROM recurring_rules WHERE category_id = ?1) AS n',
          variables: [Variable<String>(id)],
        )
        .getSingle();
    return row.read<int>('n');
  }

  Future<int> delete(String id) =>
      (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();

  /// Points every transaction of [fromId] at [intoId].
  Future<int> reassignTransactions(
    String fromId,
    String intoId, {
    required int updatedAt,
  }) =>
      (_db.update(
        _db.transactions,
      )..where((t) => t.categoryId.equals(fromId))).write(
        TransactionsCompanion(
          categoryId: Value(intoId),
          updatedAt: Value(updatedAt),
        ),
      );

  /// Points every recurring rule of [fromId] at [intoId].
  Future<int> reassignRules(
    String fromId,
    String intoId, {
    required int updatedAt,
  }) =>
      (_db.update(
        _db.recurringRules,
      )..where((r) => r.categoryId.equals(fromId))).write(
        RecurringRulesCompanion(
          categoryId: Value(intoId),
          updatedAt: Value(updatedAt),
        ),
      );
}
