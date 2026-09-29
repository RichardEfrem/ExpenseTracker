import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/recurring/data/datasources/recurring_local_datasource.dart';
import 'package:expense_tracker/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/recurring/domain/usecases/generate_due_occurrences.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late RecurringRepositoryImpl repo;
  late GenerateDueOccurrences generate;
  late String cash;
  late String housing;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock(DateTime(2026, 9, 29, 9));
    repo = RecurringRepositoryImpl(
      RecurringLocalDataSource(db),
      clock,
      const UuidGenerator(),
    );
    generate = GenerateDueOccurrences(repo, clock);
    cash = (await db.select(db.accounts).getSingle()).id;
    housing = (await (db.select(
      db.categories,
    )..where((c) => c.type.equals('expense'))).get()).first.id;
  });
  tearDown(() => db.close());

  RecurringRuleInput rent({
    String start = '2026-07-31',
    String? end,
    bool autoCreate = true,
  }) => RecurringRuleInput(
    type: TransactionType.expense,
    amount: 3000000,
    accountId: cash,
    categoryId: housing,
    note: 'Rent',
    frequency: RecurrenceFrequency.monthly,
    dayOfMonth: LocalDate.parse(start).day,
    startDate: LocalDate.parse(start),
    endDate: end == null ? null : LocalDate.parse(end),
    autoCreate: autoCreate,
  );

  Future<RecurringRule> create(RecurringRuleInput input) async =>
      (await repo.create(input)).getOrElse((f) => fail('$f'));

  Future<GenerationResult> run() async =>
      (await generate()).getOrElse((f) => fail('$f'));

  Future<List<TransactionRow>> transactions() => (db.select(
    db.transactions,
  )..orderBy([(t) => OrderingTerm.asc(t.date)])).get();

  Future<List<PendingView>> pending() async =>
      (await repo.watchPending().first).getOrElse((f) => fail('$f'));

  test('create stores the rule and lists it with its category', () async {
    final rule = await create(rent());
    expect(rule.lastGeneratedDate, isNull);
    final views = (await repo.watchRules().first).getOrElse((f) => fail('$f'));
    expect(views.single.rule, rule);
    expect(views.single.category!.id, housing);
    expect(views.single.account.id, cash);
  });

  group('generation (REC-02)', () {
    test('auto rules create every due date up to today', () async {
      final rule = await create(rent());
      expect(await run(), const GenerationResult(created: 2));
      final rows = await transactions();
      expect([for (final t in rows) t.date], ['2026-07-31', '2026-08-31']);
      for (final t in rows) {
        expect(
          (t.type, t.amount, t.categoryId, t.note, t.time, t.recurringRuleId),
          ('expense', 3000000, housing, 'Rent', '00:00', rule.id),
        );
      }
      final stored = (await repo.getRule(rule.id)).toNullable()!;
      expect(stored.lastGeneratedDate, LocalDate(2026, 9, 29));
      expect(stored.nextDate, LocalDate(2026, 9, 30));
    });

    test('running twice creates nothing new (idempotent)', () async {
      await create(rent());
      await run();
      expect(await run(), const GenerationResult());
      expect(await transactions(), hasLength(2));
    });

    test('overlapping runs never duplicate', () async {
      await create(rent());
      await create(
        rent(
          start: '2026-09-01',
        ).copyWith(frequency: RecurrenceFrequency.daily),
      );
      final results = await Future.wait([generate(), generate(), generate()]);
      final created = results.fold(
        0,
        (sum, r) => sum + r.getOrElse((f) => fail('$f')).created,
      );
      // 2 month ends + 29 days of September, exactly once.
      expect(created, 31);
      expect(await transactions(), hasLength(31));
    });

    test('a later open generates only the new dates', () async {
      await create(rent());
      await run();
      clock.current = DateTime(2026, 12, 1, 8);
      expect(await run(), const GenerationResult(created: 3));
      expect(
        [for (final t in await transactions()) t.date],
        ['2026-07-31', '2026-08-31', '2026-09-30', '2026-10-31', '2026-11-30'],
      );
    });

    test('the end date stops generation', () async {
      await create(rent(end: '2026-08-31'));
      clock.current = DateTime(2027, 3, 1);
      await run();
      expect(await transactions(), hasLength(2));
    });

    test('a future start generates nothing yet', () async {
      final rule = await create(rent(start: '2026-10-25'));
      expect(await run(), const GenerationResult());
      expect(
        (await repo.getRule(rule.id)).toNullable()!.nextDate,
        LocalDate(2026, 10, 25),
      );
    });

    test('a plan read before an edit is skipped, not applied stale', () async {
      final rule = await create(rent());
      final stalePlan = RuleGeneration(
        rule: rule,
        dates: [LocalDate(2026, 7, 31)],
        through: LocalDate(2026, 9, 29),
      );
      clock.current = clock.current.add(const Duration(minutes: 1));
      await repo.update(rule.id, rent().copyWith(amount: 3500000));
      expect(
        (await repo.saveGeneration([stalePlan])).toNullable(),
        const GenerationResult(),
      );
      expect(await transactions(), isEmpty);
      await run();
      expect({for (final t in await transactions()) t.amount}, {3500000});
    });
  });

  group('pending rules (REC-03)', () {
    test('queue items instead of transactions, oldest first', () async {
      await create(rent(autoCreate: false));
      expect(await run(), const GenerationResult(pending: 2));
      expect(await transactions(), isEmpty);
      final items = await pending();
      expect(
        [for (final p in items) p.pending.date.toIso()],
        ['2026-07-31', '2026-08-31'],
      );
      expect(items.first.rule.category!.id, housing);
      expect(await run(), const GenerationResult(), reason: 'idempotent');
      expect(await pending(), hasLength(2));
    });

    test('confirm creates the transaction on the due date', () async {
      final rule = await create(rent(autoCreate: false));
      await run();
      final first = (await pending()).first.pending;
      expect((await repo.confirmPending(first.id)).isRight(), isTrue);
      final t = (await transactions()).single;
      expect(
        (t.date, t.amount, t.recurringRuleId),
        ('2026-07-31', 3000000, rule.id),
      );
      expect(await pending(), hasLength(1));
    });

    test('skip removes the item without a transaction, for good', () async {
      await create(rent(autoCreate: false));
      await run();
      final first = (await pending()).first.pending;
      expect((await repo.skipPending(first.id)).isRight(), isTrue);
      await run();
      expect(await transactions(), isEmpty);
      expect(
        [for (final p in await pending()) p.pending.date.toIso()],
        ['2026-08-31'],
      );
    });

    test('resolving a missing item is NotFound', () async {
      expect(
        (await repo.confirmPending('nope')).getLeft().toNullable(),
        isA<NotFoundFailure>(),
      );
      expect(
        (await repo.skipPending('nope')).getLeft().toNullable(),
        isA<NotFoundFailure>(),
      );
    });
  });

  test('update keeps the generation state', () async {
    final rule = await create(rent());
    await run();
    await repo.update(rule.id, rent().copyWith(note: null, amount: 2900000));
    final stored = (await repo.getRule(rule.id)).toNullable()!;
    expect(stored.lastGeneratedDate, LocalDate(2026, 9, 29));
    expect(stored.note, isNull, reason: 'explicit null clears the note');
    expect(await run(), const GenerationResult());
  });

  test(
    'delete removes the rule and its pending items; transactions stay',
    () async {
      final auto = await create(rent());
      final asks = await create(rent(autoCreate: false));
      await run();
      expect((await repo.delete(auto.id)).isRight(), isTrue);
      expect((await repo.delete(asks.id)).isRight(), isTrue);
      final rows = await transactions();
      expect(rows, hasLength(2));
      expect(rows.every((t) => t.recurringRuleId == null), isTrue);
      expect(await pending(), isEmpty);
      expect(await db.select(db.recurringRules).get(), isEmpty);
      expect(
        (await repo.delete(auto.id)).getLeft().toNullable(),
        isA<NotFoundFailure>(),
      );
    },
  );

  test('rules list soonest next date first, ended rules last', () async {
    await create(rent(start: '2026-07-31', end: '2026-08-31'));
    await create(rent(start: '2026-10-05'));
    await create(rent(start: '2026-09-30'));
    await run();
    final views = (await repo.watchRules().first).toNullable()!;
    expect(
      [for (final v in views) v.rule.nextDate?.toIso()],
      ['2026-09-30', '2026-10-05', null],
    );
  });
}
