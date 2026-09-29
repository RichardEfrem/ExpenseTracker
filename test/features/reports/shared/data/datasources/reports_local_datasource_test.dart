import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:flutter_test/flutter_test.dart';

/// Aggregations over a fixed fixture with known totals. Transfers and
/// adjustments are in the data and must never count.
void main() {
  late AppDatabase db;
  late ReportsLocalDataSource source;
  late String cash;
  const bank = 'bank';
  late Map<String, String> cat;
  var seq = 0;

  Future<void> add(
    String type,
    String date,
    int amount, {
    String? category,
    String? account,
    String? to,
  }) => db
      .into(db.transactions)
      .insert(
        TransactionsCompanion.insert(
          id: 't${seq++}',
          type: type,
          amount: amount,
          accountId: account ?? cash,
          toAccountId: Value(to),
          categoryId: Value(category == null ? null : cat[category]),
          date: date,
          time: '12:00',
          createdAt: seq,
          updatedAt: seq,
        ),
      );

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    source = ReportsLocalDataSource(db);
    cash = (await db.select(db.accounts).getSingle()).id;
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
    cat = {for (final c in await db.select(db.categories).get()) c.name: c.id};

    // September 2026.
    await add('income', '2026-09-01', 8500000, category: 'Salary');
    await add('expense', '2026-09-05', 45000, category: 'Food & Drinks');
    await add('expense', '2026-09-05', 20000, category: 'Food & Drinks');
    await add(
      'expense',
      '2026-09-10',
      100000,
      category: 'Transport',
      account: bank,
    );
    await add('expense', '2026-09-24', 300000, category: 'Groceries');
    await add('expense', '2026-09-25', 50000, category: 'Food & Drinks');
    await add('transfer', '2026-09-12', 500000, to: bank);
    await add('adjustment', '2026-09-13', 10000);
    // August 2026.
    await add('expense', '2026-08-20', 200000, category: 'Shopping');
    await add('income', '2026-08-26', 1000000, category: 'Freelance');
    // Leap day.
    await add('expense', '2024-02-29', 75000, category: 'Health');
  });
  tearDown(() => db.close());

  final sep = ReportScope(
    period: Period.monthContaining(LocalDate(2026, 9, 1)),
  );
  final sep25 = ReportScope(
    period: Period.monthContaining(LocalDate(2026, 9, 1), startDay: 25),
  );

  test('totals exclude transfers and adjustments', () async {
    expect(await source.totals(sep), (income: 8500000, expense: 515000));
  });

  test('totals respect month start day 25 (25 Aug – 24 Sep)', () async {
    expect(await source.totals(sep25), (income: 9500000, expense: 465000));
  });

  test('leap February, calendar and start day 25', () async {
    final feb = ReportScope(
      period: Period.monthContaining(LocalDate(2024, 2, 1)),
    );
    expect(await source.totals(feb), (income: 0, expense: 75000));
    final feb25 = ReportScope(
      period: Period.monthContaining(LocalDate(2024, 2, 29), startDay: 25),
    );
    expect(feb25.period.start, LocalDate(2024, 2, 25));
    expect((await source.totals(feb25)).expense, 75000);
  });

  test('account scope', () async {
    final bankOnly = sep.copyWith(accountIds: {bank});
    expect(await source.totals(bankOnly), (income: 0, expense: 100000));
  });

  test('by category: largest first, with counts', () async {
    final rows = await source.byCategory(sep, 'expense');
    expect(
      [for (final (row, amount, count) in rows) (row.name, amount, count)],
      [
        ('Groceries', 300000, 1),
        ('Food & Drinks', 115000, 3),
        ('Transport', 100000, 1),
      ],
    );
    expect((await source.byCategory(sep, 'income')).single.$2, 8500000);
  });

  test('by periods: one GROUP BY over consecutive buckets', () async {
    final periods = [
      Period.monthContaining(LocalDate(2026, 7, 1)),
      Period.monthContaining(LocalDate(2026, 8, 1)),
      Period.monthContaining(LocalDate(2026, 9, 1)),
    ];
    expect(await source.byPeriods(periods, const {}), [
      (bucket: 1, income: 1000000, expense: 200000),
      (bucket: 2, income: 8500000, expense: 515000),
    ]);
  });

  test('daily expense per day', () async {
    expect(await source.dailyExpense(sep), {
      LocalDate(2026, 9, 5): 65000,
      LocalDate(2026, 9, 10): 100000,
      LocalDate(2026, 9, 24): 300000,
      LocalDate(2026, 9, 25): 50000,
    });
  });

  test('largest expense, most frequent category, expense days', () async {
    final largest = await source.largestExpense(sep);
    expect(largest?.amount, 300000);
    expect(largest?.categoryId, cat['Groceries']);
    expect(await source.mostFrequentCategory(sep), (
      categoryId: cat['Food & Drinks']!,
      count: 3,
    ));
    expect(await source.expenseDayCount(sep, LocalDate(2026, 9, 29)), 4);
    expect(await source.expenseDayCount(sep, LocalDate(2026, 9, 9)), 1);
  });

  test('latest date with data before a date', () async {
    expect(
      await source.latestDateBefore(LocalDate(2026, 9, 1), const {}),
      LocalDate(2026, 8, 26),
    );
    expect(
      await source.latestDateBefore(LocalDate(2026, 8, 1), const {}),
      LocalDate(2024, 2, 29),
    );
    expect(
      await source.latestDateBefore(LocalDate(2024, 1, 1), const {}),
      isNull,
    );
  });

  test('watch re-runs after a write', () async {
    final stream = source.watch(() => source.totals(sep)).map((t) => t.expense);
    final expectation = expectLater(stream, emitsInOrder([515000, 516000]));
    await Future<void>.delayed(Duration.zero);
    await add('expense', '2026-09-28', 1000, category: 'Food & Drinks');
    await expectation;
  });
}
