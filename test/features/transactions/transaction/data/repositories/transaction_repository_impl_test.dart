import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/transactions/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:expense_tracker/features/transactions/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/add_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/duplicate_transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late TransactionRepositoryImpl repo;
  late FixedClock clock;
  late String cash;
  late String food;
  late String salary;

  setUp(() async {
    clock = FixedClock(DateTime.utc(2026, 9, 29, 5));
    db = AppDatabase(NativeDatabase.memory(), clock: clock);
    repo = TransactionRepositoryImpl(
      TransactionLocalDataSource(db),
      clock,
      const UuidGenerator(),
    );
    cash = (await db.select(db.accounts).getSingle()).id;
    final categories = await db.select(db.categories).get();
    food = categories.firstWhere((c) => c.name == 'Food & Drinks').id;
    salary = categories.firstWhere((c) => c.name == 'Salary').id;
  });
  tearDown(() => db.close());

  TransactionInput expense({int amount = 45000, String? note}) =>
      TransactionInput(
        type: TransactionType.expense,
        amount: amount,
        accountId: cash,
        categoryId: food,
        date: LocalDate(2026, 9, 29),
        time: const LocalTime(12, 30),
        note: note,
      );

  Future<Transaction> add(TransactionInput input) async =>
      (await repo.add(input)).getOrElse((f) => fail('$f'));

  Future<int> count() async => (await db.select(db.transactions).get()).length;

  test('add stores every field and remembers last used', () async {
    final t = await add(expense(note: 'Lunch'));
    expect(t.amount, 45000);
    expect(t.date, LocalDate(2026, 9, 29));
    expect(t.time, const LocalTime(12, 30));
    expect(t.note, 'Lunch');
    expect(t.createdAt, clock.current);
    final last = (await repo.getLastUsed(
      TransactionType.expense,
    )).getOrElse((f) => fail('$f'));
    expect(last, LastUsed(categoryId: food, accountId: cash));
    final income = (await repo.getLastUsed(
      TransactionType.income,
    )).getOrElse((f) => fail('$f'));
    expect(income, const LastUsed());
  });

  test('update changes fields and clears a removed note', () async {
    final t = await add(expense(note: 'Lunch'));
    clock.current = DateTime.utc(2026, 9, 30);
    final result = await repo.update(t.id, expense(amount: 50000));
    expect(result.isRight(), isTrue);
    final updated = (await repo.get(t.id)).getOrElse((f) => fail('$f'));
    expect(updated.amount, 50000);
    expect(updated.note, isNull);
    expect(updated.createdAt, t.createdAt);
    expect(updated.updatedAt, DateTime.utc(2026, 9, 30));
  });

  test('update and delete of a missing id are NotFound', () async {
    expect(
      (await repo.update('x', expense())).getLeft().toNullable(),
      isA<NotFoundFailure>(),
    );
    expect(
      (await repo.delete('x')).getLeft().toNullable(),
      isA<NotFoundFailure>(),
    );
  });

  test('delete then restore brings back the identical row (undo)', () async {
    final t = await add(expense(note: 'Lunch'));
    final before = await db.select(db.transactions).getSingle();
    final deleted = (await repo.delete(t.id)).getOrElse((f) => fail('$f'));
    expect(await count(), 0);
    expect(deleted, t);

    expect((await repo.restore(deleted)).isRight(), isTrue);
    expect(await db.select(db.transactions).getSingle(), before);
  });

  test('a failed write leaves nothing behind (atomic add)', () async {
    // The row insert succeeds, then remembering last-used fails: the whole
    // DB transaction must roll back.
    await db.customStatement(
      "CREATE TRIGGER fail_settings BEFORE INSERT ON settings "
      "BEGIN SELECT RAISE(ABORT, 'boom'); END",
    );
    final result = await repo.add(expense());
    expect(result.getLeft().toNullable(), isA<DatabaseFailure>());
    expect(await count(), 0);
  });

  test('an unknown category is rejected by the database', () async {
    final result = await repo.add(expense().copyWith(categoryId: 'missing'));
    expect(result.getLeft().toNullable(), isA<DatabaseFailure>());
    expect(await count(), 0);
  });

  test('AddTransaction validates before writing', () async {
    final result = await AddTransaction(repo)(expense(amount: 0));
    expect(
      result.getLeft().toNullable(),
      const Failure.validation(ValidationReason.amountNotPositive),
    );
    expect(await count(), 0);
  });

  test('duplicate copies the fields with today\'s date and a new id', () async {
    final t = await add(
      expense(note: 'Coffee').copyWith(date: LocalDate(2026, 9, 1)),
    );
    clock.current = DateTime(2026, 9, 29, 19, 45);
    final copy = (await DuplicateTransaction(repo, clock)(
      t.id,
    )).getOrElse((f) => fail('$f'));
    expect(copy.id, isNot(t.id));
    expect(copy.amount, t.amount);
    expect(copy.note, 'Coffee');
    expect(copy.categoryId, food);
    expect(copy.date, LocalDate(2026, 9, 29));
    expect(copy.time, const LocalTime(19, 45));
  });

  test(
    'watchRecent is newest first with category and account joined',
    () async {
      await add(expense().copyWith(date: LocalDate(2026, 9, 1)));
      await add(
        expense().copyWith(
          type: TransactionType.income,
          categoryId: salary,
          amount: 8500000,
        ),
      );
      final recent = (await repo.watchRecent(5).first).getOrElse(
        (f) => fail('$f'),
      );
      expect(recent.map((v) => v.category!.name), ['Salary', 'Food & Drinks']);
      expect(recent.first.account.name, 'Cash');
      expect((await repo.watchRecent(1).first).toNullable(), hasLength(1));
    },
  );

  test('watch emits null after delete', () async {
    final t = await add(expense());
    final stream = repo.watch(t.id).map((e) => e.toNullable()?.transaction.id);
    final expectation = expectLater(stream, emitsInOrder([t.id, null]));
    await Future<void>.delayed(Duration.zero);
    await repo.delete(t.id);
    await expectation;
  });
}
