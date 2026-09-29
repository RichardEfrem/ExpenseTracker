import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/categories/data/datasources/category_local_datasource.dart';
import 'package:expense_tracker/features/categories/data/repositories/category_repository_impl.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late CategoryRepositoryImpl repo;
  late FixedClock clock;

  setUp(() {
    clock = FixedClock(DateTime.utc(2026, 9, 29));
    db = AppDatabase(NativeDatabase.memory(), clock: clock);
    repo = CategoryRepositoryImpl(
      CategoryLocalDataSource(db),
      clock,
      const UuidGenerator(),
    );
  });
  tearDown(() => db.close());

  Future<List<Category>> list(
    CategoryType type, {
    bool archived = false,
  }) async => (await repo.watchAll(type: type, includeArchived: archived).first)
      .getOrElse((f) => fail('$f'));

  Future<Category> byName(
    String name, [
    CategoryType type = CategoryType.expense,
  ]) async =>
      (await list(type, archived: true)).firstWhere((c) => c.name == name);

  Future<void> addTransaction(String categoryId, {String id = 't1'}) async {
    final account = await db.select(db.accounts).getSingle();
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            type: 'expense',
            amount: 1000,
            accountId: account.id,
            categoryId: Value(categoryId),
            date: '2026-09-29',
            time: '12:00',
            createdAt: 0,
            updatedAt: 0,
          ),
        );
  }

  Future<List<String?>> transactionCategories() async => [
    for (final t in await db.select(db.transactions).get()) t.categoryId,
  ];

  const coffee = CategoryInput(
    name: 'Coffee',
    type: CategoryType.expense,
    icon: 'local_cafe',
    color: PaletteColor.brown,
  );

  test('create appends to the end of its type', () async {
    final created = (await repo.create(coffee)).getOrElse((f) => fail('$f'));
    expect(created.name, 'Coffee');
    expect(created.sortOrder, 10);
    expect(created.createdAt, clock.current);
    expect((await list(CategoryType.expense)).last.id, created.id);
    expect(await list(CategoryType.income), hasLength(4));
  });

  test('update changes fields but never the type', () async {
    final food = await byName('Food & Drinks');
    clock.current = DateTime.utc(2026, 9, 30);
    final result = await repo.update(
      food.id,
      coffee.copyWith(type: CategoryType.income),
    );
    expect(result.isRight(), isTrue);
    final updated = await byName('Coffee');
    expect(updated.type, CategoryType.expense);
    expect(updated.icon, 'local_cafe');
    expect(updated.color, PaletteColor.brown);
    expect(updated.updatedAt, DateTime.utc(2026, 9, 30));
  });

  test('update of a missing id is NotFound', () async {
    expect(
      (await repo.update('nope', coffee)).getLeft().toNullable(),
      isA<NotFoundFailure>(),
    );
  });

  test('archive hides from pickers, keeps it listed last when asked', () async {
    final food = await byName('Food & Drinks');
    await repo.setArchived(food.id, archived: true);
    expect(
      (await list(CategoryType.expense)).map((c) => c.id),
      isNot(contains(food.id)),
    );
    final all = await list(CategoryType.expense, archived: true);
    expect(all.last.id, food.id);
    expect(all.last.isArchived, isTrue);

    await repo.setArchived(food.id, archived: false);
    expect((await list(CategoryType.expense)).first.id, food.id);
  });

  test('delete removes an unused category', () async {
    final gift = await byName('Gift', CategoryType.income);
    expect((await repo.delete(gift.id)).isRight(), isTrue);
    expect(
      (await list(CategoryType.income)).map((c) => c.name),
      isNot(contains('Gift')),
    );
  });

  test('delete of a category in use fails and keeps it (CAT-05)', () async {
    final food = await byName('Food & Drinks');
    await addTransaction(food.id);
    final result = await repo.delete(food.id);
    expect(
      result.getLeft().toNullable(),
      const Failure.validation(ValidationReason.categoryInUse),
    );
    expect(await byName('Food & Drinks'), isNotNull);
  });

  test(
    'merge reassigns transactions and deletes the source (CAT-06)',
    () async {
      final food = await byName('Food & Drinks');
      final groceries = await byName('Groceries');
      await addTransaction(food.id, id: 't1');
      await addTransaction(food.id, id: 't2');

      final result = await repo.merge(fromId: food.id, intoId: groceries.id);
      expect(result.isRight(), isTrue);
      expect(await transactionCategories(), [groceries.id, groceries.id]);
      expect(
        (await list(CategoryType.expense, archived: true)).map((c) => c.id),
        isNot(contains(food.id)),
      );
    },
  );

  test('merge across types is rejected', () async {
    final food = await byName('Food & Drinks');
    final salary = await byName('Salary', CategoryType.income);
    expect(
      (await repo.merge(
        fromId: food.id,
        intoId: salary.id,
      )).getLeft().toNullable(),
      const Failure.validation(ValidationReason.categoryTypeMismatch),
    );
  });

  test(
    'merge is atomic: a failing delete rolls back the reassignment',
    () async {
      final food = await byName('Food & Drinks');
      final groceries = await byName('Groceries');
      await addTransaction(food.id);
      await db.customStatement(
        "CREATE TRIGGER fail_delete BEFORE DELETE ON categories "
        "BEGIN SELECT RAISE(ABORT, 'boom'); END",
      );

      final result = await repo.merge(fromId: food.id, intoId: groceries.id);
      expect(result.getLeft().toNullable(), isA<DatabaseFailure>());
      expect(await transactionCategories(), [food.id]);
      expect(await byName('Food & Drinks'), isNotNull);
    },
  );

  test('reorder writes positions in the given order', () async {
    final income = await list(CategoryType.income);
    final reversed = income.reversed.map((c) => c.id).toList();
    expect((await repo.reorder(reversed)).isRight(), isTrue);
    expect((await list(CategoryType.income)).map((c) => c.id), reversed);
  });

  test('usage counts per category', () async {
    final food = await byName('Food & Drinks');
    await addTransaction(food.id, id: 't1');
    await addTransaction(food.id, id: 't2');
    final counts = (await repo.watchUsageCounts().first).getOrElse(
      (f) => fail('$f'),
    );
    expect(counts, {food.id: 2});
  });
}
