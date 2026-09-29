import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/raw_values.dart';
import 'package:expense_tracker/features/recurring/data/models/recurring_rule_model.dart';

/// A pending row with its rule, the rule's category and accounts.
typedef JoinedPendingRow = ({PendingOccurrenceRow pending, JoinedRuleRow rule});

/// SQL for recurring rules, pending occurrences and the transactions they
/// generate.
class RecurringLocalDataSource {
  RecurringLocalDataSource(this._db);

  final AppDatabase _db;
  late final _toAccount = _db.alias(_db.accounts, 'to_account');

  Future<T> transaction<T>(Future<T> Function() action) =>
      _db.transaction(action);

  /// Joins a rule's category and accounts onto a query over rules.
  List<Join<HasResultSet, dynamic>> get _ruleJoins => [
    leftOuterJoin(
      _db.categories,
      _db.categories.id.equalsExp(_db.recurringRules.categoryId),
    ),
    innerJoin(
      _db.accounts,
      _db.accounts.id.equalsExp(_db.recurringRules.accountId),
    ),
    leftOuterJoin(
      _toAccount,
      _toAccount.id.equalsExp(_db.recurringRules.toAccountId),
    ),
  ];

  JoinedRuleRow _readRule(TypedResult row) => (
    rule: row.readTable(_db.recurringRules),
    category: row.readTableOrNull(_db.categories),
    account: row.readTable(_db.accounts),
    toAccount: row.readTableOrNull(_toAccount),
  );

  Stream<List<JoinedRuleRow>> watchRules() {
    final query = _db.select(_db.recurringRules).join(_ruleJoins)
      ..orderBy([OrderingTerm.asc(_db.recurringRules.createdAt)]);
    return query.watch().map((rows) => rows.map(_readRule).toList());
  }

  /// Oldest due date first.
  Stream<List<JoinedPendingRow>> watchPending() {
    final query =
        _db.select(_db.pendingOccurrences).join([
          innerJoin(
            _db.recurringRules,
            _db.recurringRules.id.equalsExp(_db.pendingOccurrences.ruleId),
          ),
          ..._ruleJoins,
        ])..orderBy([
          OrderingTerm.asc(_db.pendingOccurrences.date),
          OrderingTerm.asc(_db.pendingOccurrences.createdAt),
        ]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          (
            pending: row.readTable(_db.pendingOccurrences),
            rule: _readRule(row),
          ),
      ],
    );
  }

  Future<RecurringRuleRow?> findRule(String id) => (_db.select(
    _db.recurringRules,
  )..where((r) => r.id.equals(id))).getSingleOrNull();

  Future<List<RecurringRuleRow>> allRules() =>
      _db.select(_db.recurringRules).get();

  Future<void> insertRule(Map<String, Object?> json) =>
      _db.into(_db.recurringRules).insert(rawValues(json));

  /// Returns the number of rows changed (0 when [id] does not exist).
  Future<int> updateRule(String id, Map<String, Object?> json) => (_db.update(
    _db.recurringRules,
  )..where((r) => r.id.equals(id))).write(rawValues(json));

  Future<int> deleteRule(String id) =>
      (_db.delete(_db.recurringRules)..where((r) => r.id.equals(id))).go();

  /// Marks the rule generated through [through], only if it is still the
  /// version that was read ([updatedAt], [lastGenerated]). 0 rows changed
  /// means another run or an edit got there first.
  Future<int> advanceRule(
    String id, {
    required int updatedAt,
    required String? lastGenerated,
    required String through,
  }) => _db.customUpdate(
    'UPDATE recurring_rules SET last_generated_date = ? '
    'WHERE id = ? AND updated_at = ? AND last_generated_date IS ?',
    variables: [
      Variable<String>(through),
      Variable<String>(id),
      Variable<int>(updatedAt),
      Variable<String>(lastGenerated),
    ],
    updates: {_db.recurringRules},
    updateKind: UpdateKind.update,
  );

  Future<PendingOccurrenceRow?> findPending(String id) => (_db.select(
    _db.pendingOccurrences,
  )..where((p) => p.id.equals(id))).getSingleOrNull();

  /// Returns false when the rule already has a pending item on that date.
  Future<bool> insertPending(Map<String, Object?> json) async =>
      await _db
          .into(_db.pendingOccurrences)
          .insertReturningOrNull(
            rawValues(json),
            mode: InsertMode.insertOrIgnore,
          ) !=
      null;

  Future<int> deletePending(String id) =>
      (_db.delete(_db.pendingOccurrences)..where((p) => p.id.equals(id))).go();

  Future<int> deletePendingOf(String ruleId) => (_db.delete(
    _db.pendingOccurrences,
  )..where((p) => p.ruleId.equals(ruleId))).go();

  Future<void> insertTransaction(Map<String, Object?> json) =>
      _db.into(_db.transactions).insert(rawValues(json));

  /// Generated transactions outlive their rule as ordinary ones.
  Future<int> unlinkTransactions(String ruleId, {required int updatedAt}) =>
      (_db.update(
        _db.transactions,
      )..where((t) => t.recurringRuleId.equals(ruleId))).write(
        TransactionsCompanion(
          recurringRuleId: const Value(null),
          updatedAt: Value(updatedAt),
        ),
      );
}
