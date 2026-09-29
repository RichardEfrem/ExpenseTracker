import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/raw_values.dart';
import 'package:expense_tracker/core/database/watch_computed.dart';
import 'package:expense_tracker/core/utils/local_date.dart';

/// SQL for accounts and their balances.
class AccountLocalDataSource {
  const AccountLocalDataSource(this._db);

  final AppDatabase _db;

  /// Every balance movement as (account, day, signed delta): a transfer
  /// leaves one account and enters another; an adjustment enters its
  /// account when `to_account_id` is set, else leaves it (PRD ACC-03/05).
  static const _moves = '''
WITH moves(acct, day, delta) AS (
  SELECT account_id, date, CASE type
    WHEN 'income' THEN amount
    WHEN 'expense' THEN -amount
    WHEN 'transfer' THEN -amount
    WHEN 'adjustment' THEN CASE WHEN to_account_id IS NULL THEN -amount ELSE 0 END
    ELSE 0 END
  FROM transactions
  UNION ALL
  SELECT to_account_id, date, amount FROM transactions
  WHERE to_account_id IS NOT NULL AND type IN ('transfer', 'adjustment')
)''';

  Future<T> transaction<T>(Future<T> Function() action) =>
      _db.transaction(action);

  Stream<T> watch<T>(Future<T> Function() compute) =>
      watchComputed(_db, [_db.accounts, _db.transactions], compute);

  SimpleSelectStatement<$AccountsTable, AccountRow> _query({
    required bool includeArchived,
  }) => _db.select(_db.accounts)
    ..where(
      (a) =>
          includeArchived ? const Constant(true) : a.isArchived.equals(false),
    )
    ..orderBy([
      (a) => OrderingTerm.asc(a.isArchived),
      (a) => OrderingTerm.asc(a.sortOrder),
      (a) => OrderingTerm.asc(a.name),
    ]);

  Stream<List<AccountRow>> watchAll({bool includeArchived = false}) =>
      _query(includeArchived: includeArchived).watch();

  Future<List<AccountRow>> getAll({bool includeArchived = false}) =>
      _query(includeArchived: includeArchived).get();

  Future<AccountRow?> firstActive() =>
      (_query(includeArchived: false)..limit(1)).getSingleOrNull();

  Future<AccountRow?> findById(String id) => (_db.select(
    _db.accounts,
  )..where((a) => a.id.equals(id))).getSingleOrNull();

  Future<int> nextSortOrder() async {
    final max = _db.accounts.sortOrder.max();
    final row = await (_db.selectOnly(
      _db.accounts,
    )..addColumns([max])).getSingle();
    return (row.read(max) ?? -1) + 1;
  }

  Future<int> activeCount() async {
    final count = _db.accounts.id.count();
    final row =
        await (_db.selectOnly(_db.accounts)
              ..addColumns([count])
              ..where(_db.accounts.isArchived.equals(false)))
            .getSingle();
    return row.read(count)!;
  }

  Future<void> insert(Map<String, Object?> json) =>
      _db.into(_db.accounts).insert(rawValues(json));

  Future<int> update(String id, Map<String, Object?> json) => (_db.update(
    _db.accounts,
  )..where((a) => a.id.equals(id))).write(rawValues(json));

  Future<int> delete(String id) =>
      (_db.delete(_db.accounts)..where((a) => a.id.equals(id))).go();

  Future<int> countUsage(String id) async {
    final row = await _db
        .customSelect(
          'SELECT COUNT(*) AS n FROM transactions '
          'WHERE account_id = ? OR to_account_id = ?',
          variables: [Variable<String>(id), Variable<String>(id)],
        )
        .getSingle();
    return row.read<int>('n');
  }

  /// Account id → sum of movements up to [asOf] (opening excluded).
  Future<Map<String, int>> movementTotals(LocalDate asOf) async {
    final rows = await _db
        .customSelect(
          '$_moves SELECT acct, SUM(delta) AS total FROM moves '
          'WHERE day <= ? GROUP BY acct',
          variables: [Variable<String>(asOf.toIso())],
        )
        .get();
    return {for (final r in rows) r.read<String>('acct'): r.read<int>('total')};
  }

  /// Account id → movement per bucket for [dates]: bucket i holds the
  /// movements after dates[i-1] up to dates[i] (bucket 0: everything up to
  /// dates[0]). One GROUP BY.
  Future<Map<String, Map<int, int>>> movementBuckets(
    List<LocalDate> dates,
  ) async {
    final cases = StringBuffer('CASE');
    for (final (i, date) in dates.indexed) {
      cases.write(" WHEN day <= '${date.toIso()}' THEN $i");
    }
    cases.write(' END');
    final rows = await _db
        .customSelect(
          '$_moves SELECT acct, $cases AS bucket, SUM(delta) AS total FROM moves '
          'WHERE day <= ? GROUP BY acct, bucket',
          variables: [Variable<String>(dates.last.toIso())],
        )
        .get();
    final result = <String, Map<int, int>>{};
    for (final r in rows) {
      result.putIfAbsent(r.read<String>('acct'), () => {})[r.read<int>(
        'bucket',
      )] = r.read<int>(
        'total',
      );
    }
    return result;
  }

  Future<void> insertTransaction(Map<String, Object?> json) =>
      _db.into(_db.transactions).insert(rawValues(json));
}
