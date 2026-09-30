import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/csv.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/csv_export/data/datasources/csv_export_local_datasource.dart';
import 'package:expense_tracker/features/backup/csv_export/data/repositories/csv_export_repository_impl.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/entities/csv_transaction_row.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CsvExportRepositoryImpl repo;
  late String cash;
  late String food;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = CsvExportRepositoryImpl(
      CsvExportLocalDataSource(db),
      const BackupFileDataSource(),
    );
    cash = (await db.select(db.accounts).getSingle()).id;
    food = (await (db.select(
      db.categories,
    )..where((c) => c.type.equals('expense'))).get()).first.id;
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: 'bca',
            name: 'BCA',
            type: 'bank',
            icon: 'account_balance',
            color: 'blue',
            sortOrder: 1,
            createdAt: 0,
            updatedAt: 0,
          ),
        );
  });
  tearDown(() => db.close());

  Future<void> add(
    String id,
    String type,
    int amount,
    String date, {
    String? category,
    String? account,
    String? toAccount,
    String? note,
    String time = '12:00',
    int createdAt = 0,
  }) => db
      .into(db.transactions)
      .insert(
        TransactionsCompanion.insert(
          id: id,
          type: type,
          amount: amount,
          accountId: account ?? cash,
          toAccountId: Value(toAccount),
          categoryId: Value(category),
          date: date,
          time: time,
          note: Value(note),
          createdAt: createdAt,
          updatedAt: createdAt,
        ),
      );

  Future<List<CsvTransactionRow>> rows([Period? range]) async =>
      (await repo.rows(range)).getOrElse((f) => fail('$f'));

  test(
    'names instead of ids, oldest first, time then creation order',
    () async {
      await add(
        'b',
        'expense',
        45000,
        '2026-09-02',
        category: food,
        note: 'Lunch',
        createdAt: 3,
      );
      await add('a', 'income', 100, '2026-09-01', category: food);
      await add('c2', 'expense', 2, '2026-09-02', category: food, createdAt: 2);
      await add('c1', 'expense', 1, '2026-09-02', category: food, createdAt: 1);
      final result = await rows();
      expect([for (final r in result) r.amount], [100, 1, 2, 45000]);
      final lunch = result.last;
      expect(lunch.category, 'Food & Drinks');
      expect(lunch.account, 'Cash');
      expect(lunch.toAccount, isNull);
      expect(lunch.note, 'Lunch');
      expect(lunch.type, TransactionType.expense);
      expect(lunch.date, LocalDate(2026, 9, 2));
    },
  );

  test('transfers name the destination; adjustments are signed', () async {
    await add('t', 'transfer', 500000, '2026-09-01', toAccount: 'bca');
    await add('in', 'adjustment', 3000, '2026-09-01', toAccount: cash);
    await add('out', 'adjustment', 2000, '2026-09-01');
    final byAmount = {for (final r in await rows()) r.amount.abs(): r};
    expect(byAmount[500000]!.toAccount, 'BCA');
    expect(byAmount[500000]!.category, isNull);
    expect(byAmount[3000]!.amount, 3000);
    expect(byAmount[3000]!.toAccount, isNull, reason: 'not a transfer');
    expect(byAmount[2000]!.amount, -2000);
  });

  test('range is inclusive at both ends', () async {
    await add('before', 'expense', 1, '2026-08-31', category: food);
    await add('first', 'expense', 2, '2026-09-01', category: food);
    await add('last', 'expense', 3, '2026-09-30', category: food);
    await add('after', 'expense', 4, '2026-10-01', category: food);
    final september = Period.monthContaining(LocalDate(2026, 9, 15));
    expect([for (final r in await rows(september)) r.amount], [2, 3]);
    expect(
      await rows(Period.custom(LocalDate(2027, 1, 1), LocalDate(2027, 1, 2))),
      isEmpty,
    );
  });

  test('encode: header, then one CRLF line per row', () async {
    await add(
      'x',
      'expense',
      45000,
      '2026-09-02',
      category: food,
      note: 'a, "b"',
    );
    final csv = repo.encode(await rows()).getOrElse((f) => fail('$f'));
    expect(
      csv,
      '${Csv.bom}date,time,type,amount,category,account,to_account,note,'
      'tags\r\n'
      '2026-09-02,12:00,expense,45000,Food & Drinks,Cash,,"a, ""b""",\r\n',
    );
  });

  test('tags: sorted names in one field; untagged is empty', () async {
    await add('x', 'expense', 1, '2026-09-02', category: food);
    await add('y', 'expense', 2, '2026-09-03', category: food);
    for (final (id, name) in [('b', 'trip-bali'), ('f', 'food')]) {
      await db
          .into(db.tags)
          .insert(TagsCompanion.insert(id: id, name: name, createdAt: 0));
      await db
          .into(db.transactionTags)
          .insert(
            TransactionTagsCompanion.insert(transactionId: 'x', tagId: id),
          );
    }
    final result = await rows();
    expect(result.first.tags, ['food', 'trip-bali']);
    expect(result.last.tags, isEmpty);
    final csv = repo.encode(result).getOrElse((f) => fail('$f'));
    expect(csv, contains(',"food, trip-bali"\r\n'));
  });
}
