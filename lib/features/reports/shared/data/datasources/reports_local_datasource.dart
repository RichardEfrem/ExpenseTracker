import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/watch_computed.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/data/models/report_rows.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';

/// Every report aggregate, each a single SQL query with GROUP BY — never a
/// loop over rows (PRD §5.4). Transfers and adjustments are always excluded:
/// only `income` and `expense` rows are read.
class ReportsLocalDataSource {
  const ReportsLocalDataSource(this._db);

  final AppDatabase _db;

  static const _moneyTypes = "t.type IN ('income', 'expense')";

  /// Re-runs [compute] whenever report inputs change.
  Stream<T> watch<T>(Future<T> Function() compute) => watchComputed(_db, [
    _db.transactions,
    _db.categories,
    _db.accounts,
  ], compute);

  /// `AND …` clauses for the scope's accounts, plus their variables.
  (String, List<Variable<Object>>) _accounts(Set<String> accountIds) {
    if (accountIds.isEmpty) return ('', const []);
    final marks = List.filled(accountIds.length, '?').join(', ');
    return (
      ' AND t.account_id IN ($marks)',
      [for (final id in accountIds) Variable<String>(id)],
    );
  }

  (String, List<Variable<Object>>) _scopeWhere(ReportScope scope) {
    final (accounts, accountVars) = _accounts(scope.accountIds);
    return (
      '$_moneyTypes AND t.date BETWEEN ? AND ?$accounts',
      [
        Variable<String>(scope.period.start.toIso()),
        Variable<String>(scope.period.end.toIso()),
        ...accountVars,
      ],
    );
  }

  Future<TotalsRow> totals(ReportScope scope) async {
    final (where, vars) = _scopeWhere(scope);
    final row = await _db
        .customSelect(
          'SELECT '
          "COALESCE(SUM(CASE WHEN t.type = 'income' THEN t.amount END), 0) AS income, "
          "COALESCE(SUM(CASE WHEN t.type = 'expense' THEN t.amount END), 0) AS expense "
          'FROM transactions t WHERE $where',
          variables: vars,
        )
        .getSingle();
    return (income: row.read<int>('income'), expense: row.read<int>('expense'));
  }

  /// Totals per category of [type], largest first.
  Future<List<(CategoryRow, int amount, int count)>> byCategory(
    ReportScope scope,
    String type,
  ) async {
    final (where, vars) = _scopeWhere(scope);
    final rows = await _db
        .customSelect(
          'SELECT c.*, SUM(t.amount) AS total, COUNT(*) AS n '
          'FROM transactions t JOIN categories c ON c.id = t.category_id '
          'WHERE $where AND t.type = ? '
          'GROUP BY t.category_id ORDER BY total DESC, c.sort_order',
          variables: [...vars, Variable<String>(type)],
          readsFrom: {_db.transactions, _db.categories},
        )
        .get();
    return [
      for (final row in rows)
        (
          await _db.categories.mapFromRow(row),
          row.read<int>('total'),
          row.read<int>('n'),
        ),
    ];
  }

  /// `CASE … END` mapping a row's date to its index in [periods], with its
  /// variables, plus the WHERE clause spanning all of them. Dates between
  /// non-consecutive periods get a NULL bucket.
  (String, List<Variable<Object>>, String, List<Variable<Object>>) _buckets(
    List<Period> periods,
  ) {
    final cases = StringBuffer('CASE');
    final vars = <Variable<Object>>[];
    for (final (i, p) in periods.indexed) {
      cases.write(' WHEN t.date BETWEEN ? AND ? THEN $i');
      vars
        ..add(Variable<String>(p.start.toIso()))
        ..add(Variable<String>(p.end.toIso()));
    }
    cases.write(' END');
    return (
      cases.toString(),
      vars,
      't.date BETWEEN ? AND ?',
      [
        Variable<String>(periods.first.start.toIso()),
        Variable<String>(periods.last.end.toIso()),
      ],
    );
  }

  /// Income and expense per consecutive period in [periods] (index =
  /// bucket), in one GROUP BY over a CASE bucket. Periods without data are
  /// absent.
  Future<List<BucketRow>> byPeriods(
    List<Period> periods,
    Set<String> accountIds,
  ) async {
    if (periods.isEmpty) return const [];
    final (cases, caseVars, span, spanVars) = _buckets(periods);
    final (accounts, accountVars) = _accounts(accountIds);
    final rows = await _db
        .customSelect(
          'SELECT $cases AS bucket, '
          "COALESCE(SUM(CASE WHEN t.type = 'income' THEN t.amount END), 0) AS income, "
          "COALESCE(SUM(CASE WHEN t.type = 'expense' THEN t.amount END), 0) AS expense "
          'FROM transactions t '
          'WHERE $_moneyTypes AND $span$accounts '
          'GROUP BY bucket ORDER BY bucket',
          variables: [...caseVars, ...spanVars, ...accountVars],
        )
        .get();
    return [
      for (final row in rows)
        if (row.readNullable<int>('bucket') case final bucket?)
          (
            bucket: bucket,
            income: row.read<int>('income'),
            expense: row.read<int>('expense'),
          ),
    ];
  }

  /// Total per category per period in [periods] (index = bucket), in one
  /// GROUP BY; only [type] (`income`/`expense`) when given. Pairs without
  /// data are absent.
  Future<List<CategoryBucketRow>> byCategoryPerPeriod(
    List<Period> periods,
    Set<String> accountIds, {
    String? type,
  }) async {
    if (periods.isEmpty) return const [];
    final (cases, caseVars, span, spanVars) = _buckets(periods);
    final (accounts, accountVars) = _accounts(accountIds);
    final rows = await _db
        .customSelect(
          'SELECT $cases AS bucket, c.*, SUM(t.amount) AS total '
          'FROM transactions t JOIN categories c ON c.id = t.category_id '
          'WHERE $_moneyTypes AND $span$accounts'
          '${type == null ? '' : ' AND t.type = ?'} '
          'GROUP BY bucket, t.category_id ORDER BY bucket, total DESC',
          variables: [
            ...caseVars,
            ...spanVars,
            ...accountVars,
            if (type != null) Variable<String>(type),
          ],
          readsFrom: {_db.transactions, _db.categories},
        )
        .get();
    return [
      for (final row in rows)
        if (row.readNullable<int>('bucket') case final bucket?)
          (
            bucket: bucket,
            category: await _db.categories.mapFromRow(row),
            amount: row.read<int>('total'),
          ),
    ];
  }

  /// Expense total per day with any expense.
  Future<Map<LocalDate, int>> dailyExpense(ReportScope scope) async {
    final (where, vars) = _scopeWhere(scope);
    final rows = await _db
        .customSelect(
          'SELECT t.date AS day, SUM(t.amount) AS total FROM transactions t '
          "WHERE $where AND t.type = 'expense' GROUP BY t.date",
          variables: vars,
        )
        .get();
    return {
      for (final row in rows)
        LocalDate.parse(row.read<String>('day')): row.read<int>('total'),
    };
  }

  /// Income minus expense per day with any income or expense.
  Future<Map<LocalDate, int>> dailyNet(ReportScope scope) async {
    final (where, vars) = _scopeWhere(scope);
    final rows = await _db
        .customSelect(
          'SELECT t.date AS day, '
          "SUM(CASE WHEN t.type = 'income' THEN t.amount ELSE -t.amount END) "
          'AS net FROM transactions t WHERE $where GROUP BY t.date',
          variables: vars,
        )
        .get();
    return {
      for (final row in rows)
        LocalDate.parse(row.read<String>('day')): row.read<int>('net'),
    };
  }

  Future<LargestExpenseRow?> largestExpense(ReportScope scope) async {
    final (where, vars) = _scopeWhere(scope);
    final row = await _db
        .customSelect(
          'SELECT t.id, t.amount, t.date, t.category_id FROM transactions t '
          "WHERE $where AND t.type = 'expense' "
          'ORDER BY t.amount DESC, t.date DESC LIMIT 1',
          variables: vars,
        )
        .getSingleOrNull();
    if (row == null) return null;
    return (
      id: row.read<String>('id'),
      amount: row.read<int>('amount'),
      date: LocalDate.parse(row.read<String>('date')),
      categoryId: row.readNullable<String>('category_id'),
    );
  }

  /// The category with the most transactions (either type).
  Future<CategoryCountRow?> mostFrequentCategory(ReportScope scope) async {
    final (where, vars) = _scopeWhere(scope);
    final row = await _db
        .customSelect(
          'SELECT t.category_id AS id, COUNT(*) AS n FROM transactions t '
          'WHERE $where AND t.category_id IS NOT NULL '
          'GROUP BY t.category_id ORDER BY n DESC, SUM(t.amount) DESC LIMIT 1',
          variables: vars,
        )
        .getSingleOrNull();
    if (row == null) return null;
    return (categoryId: row.read<String>('id'), count: row.read<int>('n'));
  }

  /// Days in the scope (up to [until]) with at least one expense.
  Future<int> expenseDayCount(ReportScope scope, LocalDate until) async {
    final (where, vars) = _scopeWhere(scope);
    final row = await _db
        .customSelect(
          'SELECT COUNT(DISTINCT t.date) AS n FROM transactions t '
          "WHERE $where AND t.type = 'expense' AND t.date <= ?",
          variables: [...vars, Variable<String>(until.toIso())],
        )
        .getSingle();
    return row.read<int>('n');
  }

  Future<CategoryRow?> category(String id) => (_db.select(
    _db.categories,
  )..where((c) => c.id.equals(id))).getSingleOrNull();

  /// The latest income/expense date before [date], for "go to last month
  /// with data".
  Future<LocalDate?> latestDateBefore(
    LocalDate date,
    Set<String> accountIds,
  ) async {
    final (accounts, accountVars) = _accounts(accountIds);
    final row = await _db
        .customSelect(
          'SELECT MAX(t.date) AS d FROM transactions t '
          'WHERE $_moneyTypes AND t.date < ?$accounts',
          variables: [Variable<String>(date.toIso()), ...accountVars],
        )
        .getSingle();
    return LocalDate.tryParse(row.readNullable<String>('d') ?? '');
  }
}
