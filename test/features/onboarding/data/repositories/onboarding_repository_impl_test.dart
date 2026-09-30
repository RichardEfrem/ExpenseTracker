import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:expense_tracker/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';
import 'package:expense_tracker/features/onboarding/domain/usecases/onboarding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  late AppDatabase db;
  late OnboardingRepositoryImpl repo;
  final clock = FixedClock(DateTime.utc(2026, 9, 30, 8));

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = OnboardingRepositoryImpl(OnboardingLocalDataSource(db), clock);
  });
  tearDown(() => db.close());

  Future<bool> pending() async =>
      (await repo.isPending()).getOrElse((f) => fail('$f'));

  Future<CategoryRow> category(String name, String type) => (db.select(
    db.categories,
  )..where((c) => c.name.equals(name) & c.type.equals(type))).getSingle();

  Future<AccountRow> cash() => db.select(db.accounts).getSingle();

  test(
    'a fresh install is pending; a database without the flag is not',
    () async {
      expect(await pending(), isTrue);
      await (db.delete(
        db.settings,
      )..where((s) => s.key.equals(onboardingPendingKey))).go();
      expect(await pending(), isFalse, reason: 'installed before onboarding');
    },
  );

  test('complete: removes categories, sets opening cash, done', () async {
    final gift = await category('Gift', 'income');
    final housing = await category('Housing / Rent', 'expense');
    final result = await repo.complete(
      OnboardingInput(
        removedCategoryIds: {gift.id, housing.id},
        openingCash: 250000,
      ),
    );
    expect(result, const Right<Failure, Unit>(unit));
    final ids = {for (final c in await db.select(db.categories).get()) c.id};
    expect(ids, isNot(contains(gift.id)));
    expect(ids, isNot(contains(housing.id)));
    final account = await cash();
    expect(account.openingBalance, 250000);
    expect(account.updatedAt, clock.now().millisecondsSinceEpoch);
    expect(await pending(), isFalse);
  });

  test('a category already in use is archived, not deleted', () async {
    final food = await category('Food & Drinks', 'expense');
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 't',
            type: 'expense',
            amount: 1000,
            accountId: (await cash()).id,
            categoryId: Value(food.id),
            date: '2026-09-30',
            time: '08:00',
            createdAt: 0,
            updatedAt: 0,
          ),
        );
    await repo.complete(OnboardingInput(removedCategoryIds: {food.id}));
    expect((await category('Food & Drinks', 'expense')).isArchived, isTrue);
  });

  test('removing every income category is refused and rolls back', () async {
    final income = await (db.select(
      db.categories,
    )..where((c) => c.type.equals('income'))).get();
    final result = await repo.complete(
      OnboardingInput(
        removedCategoryIds: {for (final c in income) c.id},
        openingCash: 1000,
      ),
    );
    expect(
      result,
      const Left<Failure, Unit>(
        Failure.validation(ValidationReason.categoryRequired),
      ),
    );
    expect(
      (await db.select(db.categories).get()).length,
      14,
      reason: 'nothing removed',
    );
    expect((await cash()).openingBalance, 0, reason: 'nothing written');
    expect(await pending(), isTrue);
  });

  test('zero cash leaves the opening balance alone', () async {
    await repo.complete(const OnboardingInput());
    expect((await cash()).openingBalance, 0);
    expect(await pending(), isFalse);
  });

  test('skip only clears the flag', () async {
    await repo.skip();
    expect(await pending(), isFalse);
    expect((await db.select(db.categories).get()).length, 14);
  });

  test('CompleteOnboarding validates before writing', () async {
    final complete = CompleteOnboarding(repo);
    expect(
      await complete(const OnboardingInput(openingCash: -1)),
      const Left<Failure, Unit>(
        Failure.validation(ValidationReason.invalidInput),
      ),
    );
    expect(
      await complete(const OnboardingInput(openingCash: 1000000000000000)),
      const Left<Failure, Unit>(
        Failure.validation(ValidationReason.amountTooLarge),
      ),
    );
    expect(await pending(), isTrue);
  });
}
