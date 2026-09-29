import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late ProviderContainer container;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock(DateTime(2026, 9, 29, 9));
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(clock),
      ],
    );
    final cash = (await db.select(db.accounts).getSingle()).id;
    await db
        .into(db.recurringRules)
        .insert(
          RecurringRulesCompanion.insert(
            id: 'coffee',
            type: 'expense',
            amount: 25000,
            accountId: cash,
            categoryId: Value((await db.select(db.categories).get()).first.id),
            frequency: 'daily',
            startDate: '2026-09-27',
            createdAt: 1,
            updatedAt: 1,
          ),
        );
  });
  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('first read (app open) generates what is due', () async {
    expect(
      await container.read(recurringGenerationProvider.future),
      const GenerationResult(created: 3),
    );
    expect(await db.select(db.transactions).get(), hasLength(3));
  });

  test('run (resume) generates only the days since', () async {
    await container.read(recurringGenerationProvider.future);
    clock.current = DateTime(2026, 10, 1, 8);
    await container.read(recurringGenerationProvider.notifier).run();
    expect(
      container.read(recurringGenerationProvider).value,
      const GenerationResult(created: 2),
    );
    await container.read(recurringGenerationProvider.notifier).run();
    expect(
      container.read(recurringGenerationProvider).value,
      const GenerationResult(),
    );
    expect(await db.select(db.transactions).get(), hasLength(5));
  });
}
