import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/accounts/data/datasources/account_local_datasource.dart';
import 'package:expense_tracker/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:expense_tracker/features/accounts/domain/usecases/watch_balance_history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountRepositoryImpl repo;
  late String cash;
  late String bank;
  var seq = 0;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = AccountRepositoryImpl(
      AccountLocalDataSource(db),
      FixedClock(DateTime.utc(2026, 9, 29)),
      const UuidGenerator(),
    );
    cash = (await db.select(db.accounts).getSingle()).id;
    bank = (await repo.create(
      const AccountInput(
        name: 'BCA',
        type: AccountType.bank,
        icon: 'account_balance',
        color: PaletteColor.blue,
        openingBalance: 1000000,
      ),
    )).getOrElse((f) => fail('$f')).id;
  });
  tearDown(() => db.close());

  Future<void> add(
    String type,
    int amount,
    String account, {
    String? to,
    String date = '2026-09-10',
  }) async {
    final category = type == 'income' || type == 'expense'
        ? (await (db.select(
            db.categories,
          )..where((c) => c.type.equals(type))).get()).first.id
        : null;
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 't${seq++}',
            type: type,
            amount: amount,
            accountId: account,
            toAccountId: Value(to),
            categoryId: Value(category),
            date: date,
            time: '12:00',
            createdAt: seq,
            updatedAt: seq,
          ),
        );
  }

  Future<Map<String, int>> balances([LocalDate? asOf]) async => {
    for (final b
        in (await repo.watchBalances(asOf ?? LocalDate(2026, 9, 29)).first)
            .getOrElse((f) => fail('$f')))
      b.account.name: b.balance,
  };

  test(
    'balance = opening + income − expense ± transfers ± adjustments (ACC-03)',
    () async {
      await add('income', 5000000, cash);
      await add('expense', 45000, cash);
      await add('expense', 100000, bank);
      await add('transfer', 500000, cash, to: bank);
      await add('adjustment', 7000, cash, to: cash); // money in
      await add('adjustment', 2000, bank); // money out
      expect(await balances(), {
        'Cash': 5000000 - 45000 - 500000 + 7000,
        'BCA': 1000000 - 100000 + 500000 - 2000,
      });
    },
  );

  test('balance as of a date ignores later rows', () async {
    await add('income', 100, cash, date: '2026-09-01');
    await add('income', 200, cash, date: '2026-09-20');
    expect((await balances(LocalDate(2026, 9, 10)))['Cash'], 100);
  });

  test('balance history per month end, with the total', () async {
    await add('income', 1000, cash, date: '2026-07-15');
    await add('transfer', 400, cash, to: bank, date: '2026-08-02');
    await add('expense', 100, bank, date: '2026-09-28');
    final dates = WatchBalanceHistory.monthEnds(LocalDate(2026, 9, 29), 3);
    expect(dates, [
      LocalDate(2026, 7, 31),
      LocalDate(2026, 8, 31),
      LocalDate(2026, 9, 29),
    ]);
    final history = (await repo.watchHistory(dates).first).getOrElse(
      (f) => fail('$f'),
    );
    expect(history.series[cash], [1000, 600, 600]);
    expect(history.series[bank], [1000000, 1000400, 1000300]);
    expect(history.totals, [1001000, 1001000, 1000900]);
  });

  test(
    'adjust balance records the difference, excluded from nothing else',
    () async {
      await add('income', 50000, cash);
      final delta = (await repo.adjustBalance(
        cash,
        45000,
        date: LocalDate(2026, 9, 29),
        time: const LocalTime(9, 0),
      )).getOrElse((f) => fail('$f'));
      expect(delta, -5000);
      expect((await balances())['Cash'], 45000);
      final adjustment = await (db.select(
        db.transactions,
      )..where((t) => t.type.equals('adjustment'))).getSingle();
      expect(adjustment.amount, 5000);
      expect(adjustment.toAccountId, isNull);

      final up = (await repo.adjustBalance(
        cash,
        60000,
        date: LocalDate(2026, 9, 29),
        time: const LocalTime(9, 0),
      )).getOrElse((f) => fail('$f'));
      expect(up, 15000);
      expect((await balances())['Cash'], 60000);
      expect(
        (await repo.adjustBalance(
          cash,
          60000,
          date: LocalDate(2026, 9, 29),
          time: const LocalTime(9, 0),
        )).getOrElse((f) => fail('$f')),
        0,
      );
    },
  );

  test('an account in use cannot be deleted; an unused one can', () async {
    await add('expense', 1, bank);
    expect(
      (await repo.delete(bank)).getLeft().toNullable(),
      const Failure.validation(ValidationReason.accountInUse),
    );
    final spare = (await repo.create(
      const AccountInput(
        name: 'Spare',
        type: AccountType.other,
        icon: 'savings',
        color: PaletteColor.neutral,
      ),
    )).getOrElse((f) => fail('$f'));
    expect((await repo.delete(spare.id)).isRight(), isTrue);
  });

  test('an account used only by a recurring rule is in use', () async {
    await db
        .into(db.recurringRules)
        .insert(
          RecurringRulesCompanion.insert(
            id: 'savings',
            type: 'transfer',
            amount: 500000,
            accountId: cash,
            toAccountId: Value(bank),
            frequency: 'monthly',
            startDate: '2026-09-25',
            createdAt: 0,
            updatedAt: 0,
          ),
        );
    for (final id in [cash, bank]) {
      expect(
        (await repo.delete(id)).getLeft().toNullable(),
        const Failure.validation(ValidationReason.accountInUse),
      );
    }
  });

  test('the last active account cannot be archived', () async {
    expect((await repo.setArchived(bank, archived: true)).isRight(), isTrue);
    expect(
      (await repo.setArchived(cash, archived: true)).getLeft().toNullable(),
      const Failure.validation(ValidationReason.lastActiveAccount),
    );
    final active = (await repo.watchAll().first).getOrElse((f) => fail('$f'));
    expect(active.map((a) => a.name), ['Cash']);
    expect((await repo.getDefault()).getOrElse((f) => fail('$f')).name, 'Cash');
  });

  test('create appends; update changes fields', () async {
    final all = (await repo.watchAll().first).getOrElse((f) => fail('$f'));
    expect(all.map((a) => (a.name, a.sortOrder)), [('Cash', 0), ('BCA', 1)]);
    await repo.update(
      bank,
      const AccountInput(
        name: 'BCA Main',
        type: AccountType.bank,
        icon: 'account_balance',
        color: PaletteColor.teal,
        openingBalance: -50000,
      ),
    );
    final updated = (await repo.watchAll().first)
        .getOrElse((f) => fail('$f'))
        .last;
    expect(
      (updated.name, updated.color, updated.openingBalance),
      ('BCA Main', PaletteColor.teal, -50000),
    );
  });
}
