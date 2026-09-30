import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:expense_tracker/features/transactions/transaction/data/models/transaction_model.dart';

/// A joined transaction row with its day's net, from one SQL query.
typedef ActivityRow = ({JoinedTransactionRow row, int dayNet});

typedef SummaryRow = ({int count, int income, int expense});

/// SQL for the Activity list: filtered, paged by date range, aggregated.
class ActivityLocalDataSource {
  ActivityLocalDataSource(this._db, this._transactions);

  final AppDatabase _db;
  final TransactionLocalDataSource _transactions;

  $TransactionsTable get _t => _db.transactions;

  /// Income − expense per day, as a window over the filtered rows.
  static const _dayNet = CustomExpression<int>(
    'SUM(CASE "transactions"."type" '
    "WHEN 'income' THEN \"transactions\".\"amount\" "
    "WHEN 'expense' THEN -\"transactions\".\"amount\" ELSE 0 END) "
    'OVER (PARTITION BY "transactions"."date")',
  );

  /// A transaction has a tag matching [where].
  Expression<bool> _hasTag(Expression<bool> Function($TagsTable g) where) {
    final link = _db.transactionTags;
    return existsQuery(
      _db.selectOnly(link).join([
          innerJoin(_db.tags, _db.tags.id.equalsExp(link.tagId)),
        ])
        ..addColumns([link.tagId])
        ..where(link.transactionId.equalsExp(_t.id) & where(_db.tags)),
    );
  }

  /// The WHERE clause for [filter], restricted to [from]..[to] (inclusive)
  /// when given. Expects `categories` joined.
  Expression<bool> _where(
    TransactionFilter filter, {
    LocalDate? from,
    LocalDate? to,
    LocalDate? before,
  }) {
    final text = filter.text.trim();
    String like(String s) =>
        '%${s.replaceAllMapped(RegExp(r'[\\%_]'), (m) => '\\${m[0]}')}%';
    final pattern = like(text);
    // Tags are stored lowercase without `#`: "#Bali" finds `bali`.
    final tagPattern = like(text.replaceFirst(RegExp('^#+'), '').toLowerCase());
    final lower = LocalDate.maxOrNull(filter.from, from);
    final upper = LocalDate.minOrNull(filter.to, to);
    return Expression.and([
      if (text.isNotEmpty)
        _t.note.like(pattern, escapeChar: r'\') |
            _db.categories.name.like(pattern, escapeChar: r'\') |
            _hasTag((g) => g.name.like(tagPattern, escapeChar: r'\')),
      if (filter.types.isNotEmpty)
        _t.type.isIn(filter.types.map((t) => t.name)),
      if (filter.categoryIds.isNotEmpty) _t.categoryId.isIn(filter.categoryIds),
      if (filter.accountIds.isNotEmpty)
        _t.accountId.isIn(filter.accountIds) |
            _t.toAccountId.isIn(filter.accountIds),
      if (filter.tags.isNotEmpty) _hasTag((g) => g.name.isIn(filter.tags)),
      if (lower != null) _t.date.isBiggerOrEqualValue(lower.toIso()),
      if (upper != null) _t.date.isSmallerOrEqualValue(upper.toIso()),
      if (before != null) _t.date.isSmallerThanValue(before.toIso()),
      if (filter.minAmount != null)
        _t.amount.isBiggerOrEqualValue(filter.minAmount!),
      if (filter.maxAmount != null)
        _t.amount.isSmallerOrEqualValue(filter.maxAmount!),
    ]);
  }

  Join<HasResultSet, dynamic> get _categoryJoin =>
      leftOuterJoin(_db.categories, _db.categories.id.equalsExp(_t.categoryId));

  /// Matching rows in [from]..[to], newest first, each with its day's net.
  Stream<List<ActivityRow>> watchRange(
    TransactionFilter filter,
    LocalDate from,
    LocalDate to,
  ) {
    final query = _transactions.joined()
      ..addColumns([_dayNet])
      ..where(_where(filter, from: from, to: to))
      ..orderBy(_transactions.newestFirst);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          (row: _transactions.readJoined(row), dayNet: row.read(_dayNet) ?? 0),
      ],
    );
  }

  /// Whether any row matching [filter] is dated before [date].
  Future<bool> existsBefore(TransactionFilter filter, LocalDate date) async {
    final query = _db.selectOnly(_t).join([_categoryJoin])
      ..addColumns([_t.id])
      ..where(_where(filter, before: date))
      ..limit(1);
    return (await query.get()).isNotEmpty;
  }

  Stream<SummaryRow> watchSummary(TransactionFilter filter) {
    final count = _t.id.count();
    final income = _t.amount.sum(filter: _t.type.equals('income'));
    final expense = _t.amount.sum(filter: _t.type.equals('expense'));
    final query = _db.selectOnly(_t).join([_categoryJoin])
      ..addColumns([count, income, expense])
      ..where(_where(filter));
    return query.watchSingle().map(
      (row) => (
        count: row.read(count) ?? 0,
        income: row.read(income) ?? 0,
        expense: row.read(expense) ?? 0,
      ),
    );
  }
}
