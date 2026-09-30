import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';

/// Onboarding's reads and writes: the pending flag, removing default
/// categories and the Cash account's opening balance.
class OnboardingLocalDataSource {
  const OnboardingLocalDataSource(this._db);

  final AppDatabase _db;

  Future<T> transaction<T>(Future<T> Function() action) =>
      _db.transaction(action);

  Future<bool> isPending() async {
    final row = await (_db.select(
      _db.settings,
    )..where((s) => s.key.equals(onboardingPendingKey))).getSingleOrNull();
    return row?.value == 'true';
  }

  Future<void> markDone() => _db
      .into(_db.settings)
      .insertOnConflictUpdate(
        SettingsCompanion.insert(key: onboardingPendingKey, value: 'false'),
      );

  /// Transactions and recurring rules that use the category.
  Future<int> countCategoryUsage(String id) async {
    final row = await _db
        .customSelect(
          'SELECT (SELECT COUNT(*) FROM transactions WHERE category_id = ?1) + '
          '(SELECT COUNT(*) FROM recurring_rules WHERE category_id = ?1) AS n',
          variables: [Variable<String>(id)],
        )
        .getSingle();
    return row.read<int>('n');
  }

  Future<void> deleteCategory(String id) =>
      (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();

  Future<void> archiveCategory(String id, int nowMs) =>
      (_db.update(_db.categories)..where((c) => c.id.equals(id))).write(
        CategoriesCompanion(
          isArchived: const Value(true),
          updatedAt: Value(nowMs),
        ),
      );

  /// Active categories per type (`expense`/`income`).
  Future<Map<String, int>> activeCategoryCounts() async {
    final count = _db.categories.id.count();
    final rows =
        await (_db.selectOnly(_db.categories)
              ..addColumns([_db.categories.type, count])
              ..where(_db.categories.isArchived.equals(false))
              ..groupBy([_db.categories.type]))
            .get();
    return {for (final r in rows) r.read(_db.categories.type)!: r.read(count)!};
  }

  /// Sets the opening balance of the default account (first active by sort
  /// order: the seeded Cash account). False when there is none.
  Future<bool> setDefaultAccountOpening(int amount, int nowMs) async {
    final account =
        await (_db.select(_db.accounts)
              ..where((a) => a.isArchived.equals(false))
              ..orderBy([(a) => OrderingTerm.asc(a.sortOrder)])
              ..limit(1))
            .getSingleOrNull();
    if (account == null) return false;
    await (_db.update(
      _db.accounts,
    )..where((a) => a.id.equals(account.id))).write(
      AccountsCompanion(openingBalance: Value(amount), updatedAt: Value(nowMs)),
    );
    return true;
  }
}
