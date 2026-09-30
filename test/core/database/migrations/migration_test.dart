import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'schema.dart';
import 'schema_v1.dart' as v1;
import 'schema_v2.dart' as v2;

/// Every schema version step gets a test here. Snapshots live in
/// `drift_schemas/`; after changing tables run
/// `dart run drift_dev schema dump lib/core/database/app_database.dart drift_schemas/`
/// and `dart run drift_dev schema generate --data-classes --companions drift_schemas/ test/core/database/migrations/`.
void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  test('a fresh install creates the current schema', () async {
    final db = AppDatabase(NativeDatabase.memory());
    await db.validateDatabaseSchema();
    expect(db.schemaVersion, GeneratedHelper.versions.last);
    await db.close();
  });

  for (final version in GeneratedHelper.versions.skip(1)) {
    test(
      'upgrading from every older version to v$version matches the snapshot',
      () async {
        for (final from in GeneratedHelper.versions.where((v) => v < version)) {
          final schema = await verifier.schemaAt(from);
          final db = AppDatabase(schema.newConnection());
          await verifier.migrateAndValidate(db, version);
          await db.close();
        }
      },
    );
  }

  test('v1 → v2 keeps every existing row', () async {
    final schema = await verifier.schemaAt(1);
    final old = v1.DatabaseAtV1(schema.newConnection());
    await old
        .into(old.accounts)
        .insert(
          v1.AccountsCompanion.insert(
            id: 'cash',
            name: 'Cash',
            type: 'cash',
            icon: 'payments',
            color: 'emerald',
            sortOrder: 0,
            createdAt: 1,
            updatedAt: 1,
          ),
        );
    await old
        .into(old.categories)
        .insert(
          v1.CategoriesCompanion.insert(
            id: 'food',
            name: 'Food',
            type: 'expense',
            icon: 'restaurant',
            color: 'orange',
            sortOrder: 0,
            createdAt: 1,
            updatedAt: 1,
          ),
        );
    await old
        .into(old.transactions)
        .insert(
          v1.TransactionsCompanion.insert(
            id: 't1',
            type: 'expense',
            amount: 45000,
            accountId: 'cash',
            categoryId: const Value('food'),
            date: '2026-09-29',
            time: '12:30',
            note: const Value('Lunch'),
            createdAt: 2,
            updatedAt: 3,
          ),
        );
    await old
        .into(old.settings)
        .insert(v1.SettingsCompanion.insert(key: 'theme_mode', value: 'dark'));
    await old.close();

    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 2);
    final t = await db.select(db.transactions).getSingle();
    expect(
      (t.id, t.amount, t.categoryId, t.note, t.date, t.time),
      ('t1', 45000, 'food', 'Lunch', '2026-09-29', '12:30'),
    );
    expect((await db.select(db.accounts).getSingle()).name, 'Cash');
    expect((await db.select(db.settings).getSingle()).value, 'dark');
    expect(await db.select(db.recurringRules).get(), isEmpty);
    // The new tables work.
    await db
        .into(db.recurringRules)
        .insert(
          RecurringRulesCompanion.insert(
            id: 'r',
            type: 'expense',
            amount: 3000000,
            accountId: 'cash',
            frequency: 'monthly',
            startDate: '2026-09-25',
            createdAt: 4,
            updatedAt: 4,
          ),
        );
    expect(await db.select(db.recurringRules).get(), hasLength(1));
    await db.close();
  });

  test('v2 → v3 keeps every existing row; tags work', () async {
    final schema = await verifier.schemaAt(2);
    final old = v2.DatabaseAtV2(schema.newConnection());
    await old
        .into(old.accounts)
        .insert(
          v2.AccountsCompanion.insert(
            id: 'cash',
            name: 'Cash',
            type: 'cash',
            icon: 'payments',
            color: 'emerald',
            sortOrder: 0,
            createdAt: 1,
            updatedAt: 1,
          ),
        );
    await old
        .into(old.transactions)
        .insert(
          v2.TransactionsCompanion.insert(
            id: 't1',
            type: 'transfer',
            amount: 45000,
            accountId: 'cash',
            date: '2026-09-29',
            time: '12:30',
            createdAt: 2,
            updatedAt: 3,
          ),
        );
    await old
        .into(old.recurringRules)
        .insert(
          v2.RecurringRulesCompanion.insert(
            id: 'r',
            type: 'expense',
            amount: 3000000,
            accountId: 'cash',
            frequency: 'monthly',
            startDate: '2026-09-25',
            createdAt: 4,
            updatedAt: 4,
          ),
        );
    await old.close();

    final db = AppDatabase(schema.newConnection());
    await verifier.migrateAndValidate(db, 3);
    expect((await db.select(db.transactions).getSingle()).amount, 45000);
    expect(await db.select(db.recurringRules).get(), hasLength(1));
    expect(await db.select(db.tags).get(), isEmpty);
    await db
        .into(db.tags)
        .insert(TagsCompanion.insert(id: 'g', name: 'trip-bali', createdAt: 5));
    await db
        .into(db.transactionTags)
        .insert(
          TransactionTagsCompanion.insert(transactionId: 't1', tagId: 'g'),
        );
    // Deleting the transaction takes its links with it.
    await db.delete(db.transactions).go();
    expect(await db.select(db.transactionTags).get(), isEmpty);
    await db.close();
  });
}
