import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/pagination/paged_result.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/activity/data/datasources/activity_local_datasource.dart';
import 'package:expense_tracker/features/transactions/activity/data/repositories/activity_repository_impl.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/day_group.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/filter_summary.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ActivityRepositoryImpl repo;
  late String cash;
  late Map<String, String> category;
  var seq = 0;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = ActivityRepositoryImpl(
      ActivityLocalDataSource(db, TransactionLocalDataSource(db)),
    );
    cash = (await db.select(db.accounts).getSingle()).id;
    category = {
      for (final c in await db.select(db.categories).get())
        '${c.type}:${c.name}': c.id,
    };
  });
  tearDown(() => db.close());

  Future<String> add(
    String date,
    int amount, {
    String type = 'expense',
    String cat = 'Food & Drinks',
    String? note,
    String time = '12:00',
  }) async {
    final id = 'tx${seq++}';
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            type: type,
            amount: amount,
            accountId: cash,
            categoryId: Value(category['$type:$cat']),
            date: date,
            time: time,
            note: Value(note),
            createdAt: seq,
            updatedAt: seq,
          ),
        );
    return id;
  }

  Future<PagedResult<DayGroup>> page(
    Period cursor, [
    TransactionFilter filter = TransactionFilter.none,
  ]) async =>
      (await repo.watchPage(filter, cursor).first).getOrElse((f) => fail('$f'));

  Future<FilterSummary> summary(TransactionFilter filter) async =>
      (await repo.watchSummary(filter).first).getOrElse((f) => fail('$f'));

  List<String> ids(PagedResult<DayGroup> page) => [
    for (final day in page.items)
      for (final v in day.items) v.transaction.id,
  ];

  group('paging', () {
    test('groups by day newest first with the daily net from SQL', () async {
      await add('2026-09-28', 45000, time: '08:00');
      await add('2026-09-28', 20000, time: '12:30');
      await add('2026-09-28', 1500000, type: 'income', cat: 'Salary');
      await add('2026-09-27', 10000);
      final result = await page(Period.monthContaining(LocalDate(2026, 9, 1)));
      expect(result.items.map((d) => d.date), [
        LocalDate(2026, 9, 28),
        LocalDate(2026, 9, 27),
      ]);
      expect(result.items.first.net, 1500000 - 45000 - 20000);
      expect(result.items.first.items.map((v) => v.transaction.time.format()), [
        '12:30',
        '12:00',
        '08:00',
      ]);
      expect(result.items.last.net, -10000);
    });

    test(
      'start day 25 bounds the page; the cursor steps to the previous month',
      () async {
        final inside = await add('2026-08-25', 1000);
        final lastDay = await add('2026-09-24', 2000);
        final after = await add('2026-09-25', 3000);
        final before = await add('2026-08-24', 4000);
        final cursor = Period.monthContaining(
          LocalDate(2026, 9, 1),
          startDay: 25,
        );
        final result = await page(cursor);
        expect(ids(result), [lastDay, inside]);
        expect(result.hasMore, isTrue);

        final previous = await page(
          Period.monthContaining(cursor.start.addDays(-1), startDay: 25),
        );
        expect(ids(previous), [before]);
        expect(previous.hasMore, isFalse);
        expect(ids(await page(cursor.next())), [after]);
      },
    );

    test('an empty month still reports older transactions', () async {
      await add('2026-07-10', 1000);
      final result = await page(Period.monthContaining(LocalDate(2026, 9, 1)));
      expect(result.items, isEmpty);
      expect(result.hasMore, isTrue);
      expect(
        (await page(Period.monthContaining(LocalDate(2026, 7, 1)))).hasMore,
        isFalse,
      );
    });
  });

  group('filters (SRCH-01, SRCH-02)', () {
    late String lunch;
    late String salary;
    late String taxi;
    final all = Period.custom(LocalDate(2026, 1, 1), LocalDate(2026, 12, 31));

    setUp(() async {
      lunch = await add('2026-09-10', 45000, note: 'Lunch with team');
      salary = await add('2026-09-01', 8500000, type: 'income', cat: 'Salary');
      taxi = await add(
        '2026-08-20',
        60000,
        cat: 'Transport',
        note: '50% off_ride',
      );
    });

    Future<List<String>> matching(TransactionFilter filter) async =>
        ids(await page(all, filter));

    test('text matches note, case-insensitive', () async {
      expect(await matching(const TransactionFilter(text: 'LUNCH')), [lunch]);
    });
    test('text matches category name', () async {
      expect(await matching(const TransactionFilter(text: 'sal')), [salary]);
    });
    test('% and _ in search are literal', () async {
      expect(await matching(const TransactionFilter(text: '50%')), [taxi]);
      // As wildcards these would match "off" and "50% off".
      expect(await matching(const TransactionFilter(text: 'o_f')), isEmpty);
      expect(await matching(const TransactionFilter(text: '%off')), isEmpty);
    });
    test('type', () async {
      expect(
        await matching(
          const TransactionFilter(types: {TransactionType.income}),
        ),
        [salary],
      );
    });
    test('categories (multi)', () async {
      expect(
        await matching(
          TransactionFilter(
            categoryIds: {
              category['expense:Transport']!,
              category['income:Salary']!,
            },
          ),
        ),
        [salary, taxi],
      );
    });
    test('account', () async {
      expect(
        await matching(TransactionFilter(accountIds: {cash})),
        hasLength(3),
      );
      expect(
        await matching(const TransactionFilter(accountIds: {'other'})),
        isEmpty,
      );
    });
    test('date range, inclusive', () async {
      expect(
        await matching(
          TransactionFilter(
            from: LocalDate(2026, 9, 1),
            to: LocalDate(2026, 9, 10),
          ),
        ),
        [lunch, salary],
      );
    });
    test('amount range, inclusive', () async {
      expect(
        await matching(
          const TransactionFilter(minAmount: 45000, maxAmount: 60000),
        ),
        [lunch, taxi],
      );
    });
    test('combined', () async {
      expect(
        await matching(
          const TransactionFilter(
            types: {TransactionType.expense},
            maxAmount: 50000,
            text: 'team',
          ),
        ),
        [lunch],
      );
    });

    test('summary counts and totals the filter (SRCH-03)', () async {
      expect(
        await summary(TransactionFilter.none),
        const FilterSummary(count: 3, income: 8500000, expense: 105000),
      );
      expect(
        await summary(
          const TransactionFilter(types: {TransactionType.expense}),
        ),
        const FilterSummary(count: 2, income: 0, expense: 105000),
      );
      expect((await summary(const TransactionFilter(text: 'zzz'))).count, 0);
    });

    test('hasMore respects the filter', () async {
      final sep = Period.monthContaining(LocalDate(2026, 9, 1));
      expect((await page(sep)).hasMore, isTrue);
      expect(
        (await page(sep, const TransactionFilter(text: 'lunch'))).hasMore,
        isFalse,
      );
    });
  });

  test('transfers count zero in the daily net', () async {
    final bank = 'bank';
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: bank,
            name: 'Bank',
            type: 'bank',
            icon: 'account_balance',
            color: 'blue',
            sortOrder: 1,
            createdAt: 0,
            updatedAt: 0,
          ),
        );
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'tr',
            type: 'transfer',
            amount: 500000,
            accountId: cash,
            toAccountId: Value(bank),
            date: '2026-09-05',
            time: '10:00',
            createdAt: 0,
            updatedAt: 0,
          ),
        );
    await add('2026-09-05', 1000);
    final result = await page(Period.monthContaining(LocalDate(2026, 9, 1)));
    expect(result.items.single.net, -1000);
    expect(result.items.single.items.first.toAccount?.name, isNull);
    expect(
      result.items.single.items.map((v) => v.transaction.type),
      contains(TransactionType.transfer),
    );
  });
}
