import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_date.dart';

typedef CsvSourceRow = ({
  String date,
  String time,
  String type,
  int amount,
  String? category,
  String account,
  String? toAccountId,
  String accountId,
  String? toAccount,
  String? note,

  /// Tag names, sorted, joined with `, `; null when untagged.
  String? tags,
});

/// Transactions with their category and account names, in one query.
class CsvExportLocalDataSource {
  const CsvExportLocalDataSource(this._db);

  final AppDatabase _db;

  /// Oldest first; both ends inclusive, either may be null (open).
  Future<List<CsvSourceRow>> rows({LocalDate? from, LocalDate? to}) async {
    final result = await _db
        .customSelect(
          'SELECT t.date, t.time, t.type, t.amount, t.note, '
          't.account_id, t.to_account_id, '
          'c.name AS category, a.name AS account, ta.name AS to_account, '
          "(SELECT GROUP_CONCAT(name, ', ') FROM (SELECT g.name FROM "
          'transaction_tags tt JOIN tags g ON g.id = tt.tag_id '
          'WHERE tt.transaction_id = t.id ORDER BY g.name)) AS tags '
          'FROM transactions t '
          'JOIN accounts a ON a.id = t.account_id '
          'LEFT JOIN accounts ta ON ta.id = t.to_account_id '
          'LEFT JOIN categories c ON c.id = t.category_id '
          'WHERE (?1 IS NULL OR t.date >= ?1) AND (?2 IS NULL OR t.date <= ?2) '
          'ORDER BY t.date, t.time, t.created_at',
          variables: [
            Variable<String>(from?.toIso()),
            Variable<String>(to?.toIso()),
          ],
          readsFrom: {
            _db.transactions,
            _db.accounts,
            _db.categories,
            _db.tags,
            _db.transactionTags,
          },
        )
        .get();
    return [
      for (final r in result)
        (
          date: r.read<String>('date'),
          time: r.read<String>('time'),
          type: r.read<String>('type'),
          amount: r.read<int>('amount'),
          category: r.readNullable<String>('category'),
          account: r.read<String>('account'),
          accountId: r.read<String>('account_id'),
          toAccountId: r.readNullable<String>('to_account_id'),
          toAccount: r.readNullable<String>('to_account'),
          note: r.readNullable<String>('note'),
          tags: r.readNullable<String>('tags'),
        ),
    ];
  }
}
