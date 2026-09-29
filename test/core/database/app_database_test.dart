import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(
      NativeDatabase.memory(),
      clock: FixedClock(DateTime.utc(2026, 9, 29, 8)),
    );
  });
  tearDown(() => db.close());

  group('seed (CAT-03, ACC-02)', () {
    test('14 categories with DESIGN §4.3 icons and colors', () async {
      final rows =
          await (db.select(db.categories)..orderBy([
                (c) => OrderingTerm.asc(c.type),
                (c) => OrderingTerm.asc(c.sortOrder),
              ]))
              .get();
      expect(rows, hasLength(14));
      expect(
        [for (final r in rows) (r.type, r.name, r.icon, r.color, r.sortOrder)],
        [
          ('expense', 'Food & Drinks', 'restaurant', 'orange', 0),
          ('expense', 'Transport', 'directions_bus', 'blue', 1),
          ('expense', 'Groceries', 'shopping_basket', 'green', 2),
          ('expense', 'Bills & Utilities', 'receipt_long', 'purple', 3),
          ('expense', 'Shopping', 'shopping_bag', 'pink', 4),
          ('expense', 'Health', 'favorite', 'teal', 5),
          ('expense', 'Entertainment', 'movie', 'violet', 6),
          ('expense', 'Education', 'school', 'amber', 7),
          ('expense', 'Housing / Rent', 'home', 'brown', 8),
          ('expense', 'Other', 'more_horiz', 'neutral', 9),
          ('income', 'Salary', 'work', 'emerald', 0),
          ('income', 'Freelance', 'laptop_mac', 'blue', 1),
          ('income', 'Gift', 'redeem', 'pink', 2),
          ('income', 'Other', 'more_horiz', 'neutral', 3),
        ],
      );
      expect(rows.every((r) => !r.isArchived), isTrue);
      expect(rows.map((r) => r.id).toSet(), hasLength(14));
      expect(
        rows.first.createdAt,
        DateTime.utc(2026, 9, 29, 8).millisecondsSinceEpoch,
      );
    });

    test('one "Cash" account with zero opening balance', () async {
      final accounts = await db.select(db.accounts).get();
      expect(accounts, hasLength(1));
      expect(accounts.single.name, 'Cash');
      expect(accounts.single.type, 'cash');
      expect(accounts.single.openingBalance, 0);
    });

    test('ids are UUID v4', () async {
      final id = (await db.select(db.accounts).getSingle()).id;
      expect(
        id,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    });
  });

  test('transactions has the four PRD §6.2 indexes', () async {
    final rows = await db
        .customSelect(
          "SELECT name, sql FROM sqlite_master WHERE type = 'index' "
          "AND tbl_name = 'transactions' AND sql IS NOT NULL",
        )
        .get();
    final byName = {
      for (final r in rows) r.read<String>('name'): r.read<String>('sql'),
    };
    expect(
      byName.keys,
      containsAll([
        'idx_transactions_date',
        'idx_transactions_category_date',
        'idx_transactions_account_date',
        'idx_transactions_type_date',
      ]),
    );
    expect(
      byName['idx_transactions_category_date'],
      contains('category_id, date'),
    );
    expect(
      byName['idx_transactions_account_date'],
      contains('account_id, date'),
    );
    expect(byName['idx_transactions_type_date'], contains('type, date'));
  });

  group('integrity', () {
    Future<String> accountId() async =>
        (await db.select(db.accounts).getSingle()).id;

    TransactionsCompanion tx({required String account, int amount = 1000}) =>
        TransactionsCompanion.insert(
          id: 'tx-$amount-$account',
          type: 'expense',
          amount: amount,
          accountId: account,
          date: '2026-09-29',
          time: '12:00',
          createdAt: 0,
          updatedAt: 0,
        );

    test('foreign keys are enforced', () async {
      await expectLater(
        db.into(db.transactions).insert(tx(account: 'missing')),
        throwsA(isA<SqliteException>()),
      );
    });

    test('amount must be positive', () async {
      final account = await accountId();
      await expectLater(
        db.into(db.transactions).insert(tx(account: account, amount: 0)),
        throwsA(isA<SqliteException>()),
      );
      await db.into(db.transactions).insert(tx(account: account));
    });
  });
}
