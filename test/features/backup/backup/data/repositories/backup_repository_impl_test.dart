import 'dart:convert';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/repositories/backup_repository_impl.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  late AppDatabase db;
  late BackupRepositoryImpl repo;
  late BackupLocalDataSource local;
  final clock = FixedClock(DateTime.utc(2026, 9, 29, 14));

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory(), clock: clock);
    local = BackupLocalDataSource(db);
    repo = BackupRepositoryImpl(local, const BackupFileDataSource(), clock);
  });
  tearDown(() => db.close());

  Future<AllRows> rows() => local.readAll();

  /// Rows as comparable, order-independent sets.
  Future<Map<String, Set<Object>>> contents() async {
    final r = await rows();
    return {
      'accounts': r.accounts.toSet(),
      'categories': r.categories.toSet(),
      'transactions': r.transactions.toSet(),
      'recurringRules': r.recurringRules.toSet(),
      'pendingOccurrences': r.pendingOccurrences.toSet(),
      'settings': r.settings.toSet(),
    };
  }

  Future<String> exportJson() async {
    final file = (await repo.snapshot(
      appVersion: '1.0.0 (1)',
    )).getOrElse((f) => fail('$f'));
    return repo.encode(file).getOrElse((f) => fail('$f'));
  }

  BackupFile decode(String json) =>
      repo.decode(json).getOrElse((f) => fail('$f'));

  Future<void> addNotedTransfer() async {
    final cash = (await db.select(db.accounts).getSingle()).id;
    await db
        .into(db.accounts)
        .insert(
          AccountsCompanion.insert(
            id: 'bank',
            name: 'Bank',
            type: 'bank',
            icon: 'account_balance',
            color: 'blue',
            openingBalance: const Value(250000),
            sortOrder: 1,
            createdAt: 1,
            updatedAt: 2,
          ),
        );
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'transfer',
            type: 'transfer',
            amount: 500000,
            accountId: cash,
            toAccountId: const Value('bank'),
            date: '2026-09-12',
            time: '07:05',
            note: const Value('Top-up "BCA", ünïcode ✓'),
            createdAt: 3,
            updatedAt: 4,
          ),
        );
    await db
        .into(db.settings)
        .insert(SettingsCompanion.insert(key: 'theme_mode', value: 'dark'));
  }

  /// An auto rule with a generated transaction, and an ask-first rule with
  /// a pending item.
  Future<void> addRecurring() async {
    final cash = (await (db.select(
      db.accounts,
    )..where((a) => a.name.equals('Cash'))).getSingle()).id;
    final housing = (await db.select(db.categories).get()).first.id;
    Future<void> rule(String id, {required bool auto}) => db
        .into(db.recurringRules)
        .insert(
          RecurringRulesCompanion.insert(
            id: id,
            type: 'expense',
            amount: 3000000,
            accountId: cash,
            categoryId: Value(housing),
            note: const Value('Rent'),
            frequency: 'monthly',
            interval: const Value(2),
            dayOfMonth: const Value(31),
            startDate: '2026-01-31',
            endDate: const Value('2027-01-31'),
            autoCreate: Value(auto),
            lastGeneratedDate: const Value('2026-09-29'),
            createdAt: 5,
            updatedAt: 6,
          ),
        );
    await rule('rent', auto: true);
    await rule('gym', auto: false);
    await db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: 'generated',
            type: 'expense',
            amount: 3000000,
            accountId: cash,
            categoryId: Value(housing),
            date: '2026-07-31',
            time: '00:00',
            recurringRuleId: const Value('rent'),
            createdAt: 7,
            updatedAt: 7,
          ),
        );
    await db
        .into(db.pendingOccurrences)
        .insert(
          PendingOccurrencesCompanion.insert(
            id: 'p1',
            ruleId: 'gym',
            date: '2026-09-30',
            createdAt: 8,
          ),
        );
  }

  test(
    'round-trip restores 100% of records identically (PRD reliability)',
    () async {
      await seedRandomTransactions(
        db,
        count: 500,
        end: LocalDate(2026, 9, 29),
        seed: 7,
      );
      await addNotedTransfer();
      await addRecurring();
      await db.customStatement(
        "UPDATE categories SET is_archived = 1 WHERE name = 'Gift'",
      );
      final before = await contents();
      expect(before['recurringRules'], hasLength(2));
      expect(before['pendingOccurrences'], hasLength(1));

      final json = await exportJson();
      expect((await repo.eraseAll()).isRight(), isTrue);
      expect(await contents(), isNot(before));

      final restored = await repo.restore(decode(json), RestoreMode.replace);
      expect(restored.isRight(), isTrue);
      expect(await contents(), before);
    },
  );

  test(
    'merge keeps existing rows and adds only new ones, no duplicates',
    () async {
      await seedRandomTransactions(
        db,
        count: 20,
        end: LocalDate(2026, 9, 29),
        seed: 1,
      );
      final backup = decode(await exportJson());

      // After the backup: one row edited, one added.
      final edited = (await db.select(db.transactions).get()).first;
      await (db.update(db.transactions)..where((t) => t.id.equals(edited.id)))
          .write(const TransactionsCompanion(amount: Value(1)));
      await addNotedTransfer();
      final beforeMerge = await rows();

      expect((await repo.restore(backup, RestoreMode.merge)).isRight(), isTrue);
      final after = await rows();
      expect(after.transactions.length, beforeMerge.transactions.length);
      expect(
        after.transactions.firstWhere((t) => t.id == edited.id).amount,
        1,
        reason: 'existing wins',
      );

      // Merging into an erased phone adds the backup's rows next to the seed.
      await repo.eraseAll();
      final seeded = await rows();
      await repo.restore(backup, RestoreMode.merge);
      final merged = await rows();
      expect(merged.transactions.length, backup.transactions.length);
      expect(
        merged.categories.length,
        seeded.categories.length + backup.categories.length,
      );
      expect(
        merged.transactions.map((t) => t.id).toSet(),
        hasLength(merged.transactions.length),
      );
    },
  );

  test('replace rolls back completely when a write fails midway', () async {
    await seedRandomTransactions(
      db,
      count: 30,
      end: LocalDate(2026, 9, 29),
      seed: 2,
    );
    final backup = decode(await exportJson());
    final before = await contents();
    await db.customStatement(
      'CREATE TRIGGER fail_insert BEFORE INSERT ON transactions '
      "BEGIN SELECT RAISE(ABORT, 'boom'); END",
    );
    final result = await repo.restore(backup, RestoreMode.replace);
    expect(result.getLeft().toNullable(), isA<DatabaseFailure>());
    expect(await contents(), before);
  });

  test('erase re-seeds a fresh install', () async {
    await seedRandomTransactions(db, count: 10, end: LocalDate(2026, 9, 29));
    await addRecurring();
    expect((await repo.eraseAll()).isRight(), isTrue);
    final r = await rows();
    expect(r.transactions, isEmpty);
    expect(r.recurringRules, isEmpty);
    expect(r.pendingOccurrences, isEmpty);
    expect(r.categories, hasLength(14));
    expect(r.accounts.single.name, 'Cash');
    // Only the fresh-install flag that shows onboarding again.
    expect(r.settings, [
      const SettingRow(key: onboardingPendingKey, value: 'true'),
    ]);
  });

  test('preview counts and date range', () async {
    await seedRandomTransactions(
      db,
      count: 40,
      end: LocalDate(2026, 9, 29),
      days: 30,
    );
    final preview = decode(await exportJson()).preview;
    expect(preview.transactions, 40);
    expect(preview.accounts, 1);
    expect(preview.categories, 14);
    expect(preview.lastDate!.isAfter(LocalDate(2026, 8, 30)), isTrue);
    expect(preview.firstDate! <= preview.lastDate!, isTrue);
    expect(preview.exportedAt, clock.current);
  });

  group('parsing', () {
    Failure? failureOf(String contents) =>
        repo.decode(contents).getLeft().toNullable();
    BackupProblem? problemOf(String contents) => switch (failureOf(contents)) {
      BackupFailure(:final problem) => problem,
      _ => null,
    };

    late Map<String, dynamic> valid;
    setUp(() async {
      await addNotedTransfer();
      valid = jsonDecode(await exportJson()) as Map<String, dynamic>;
    });

    test(
      'valid file decodes',
      () => expect(failureOf(jsonEncode(valid)), isNull),
    );
    test(
      'empty file',
      () => expect(problemOf('  \n'), BackupProblem.emptyFile),
    );
    test(
      'not JSON',
      () => expect(problemOf('{oops'), BackupProblem.corruptFile),
    );
    test(
      'other JSON',
      () => expect(problemOf('[1, 2]'), BackupProblem.corruptFile),
    );
    test('missing format marker', () {
      expect(
        problemOf(jsonEncode({...valid}..remove('format'))),
        BackupProblem.corruptFile,
      );
    });
    test('future schema version', () {
      expect(
        problemOf(
          jsonEncode({
            ...valid,
            'schema_version': BackupFile.currentSchemaVersion + 1,
          }),
        ),
        BackupProblem.unsupportedVersion,
      );
    });
    test('missing field', () {
      final broken = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
      ((broken['transactions'] as List).first as Map).remove('amount');
      expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
    });
    test('wrong type', () {
      final broken = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
      ((broken['accounts'] as List).first as Map)['opening_balance'] = 'lots';
      expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
    });
    test('bad date or unknown type', () {
      final badDate = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
      ((badDate['transactions'] as List).first as Map)['date'] = '2026-02-30';
      expect(problemOf(jsonEncode(badDate)), BackupProblem.corruptFile);
      final badType = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
      ((badType['transactions'] as List).first as Map)['type'] = 'refund';
      expect(problemOf(jsonEncode(badType)), BackupProblem.corruptFile);
    });
    test('dangling reference', () {
      final broken = jsonDecode(jsonEncode(valid)) as Map<String, dynamic>;
      ((broken['transactions'] as List).first as Map)['account_id'] = 'ghost';
      expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
    });

    group('recurring (schema v2)', () {
      late Map<String, dynamic> withRules;
      setUp(() async {
        await addRecurring();
        withRules = jsonDecode(await exportJson()) as Map<String, dynamic>;
      });
      Map<String, dynamic> copy() =>
          jsonDecode(jsonEncode(withRules)) as Map<String, dynamic>;

      test('exports as v2 with both lists', () {
        expect(withRules['schema_version'], 2);
        expect(withRules['recurring_rules'], hasLength(2));
        expect(withRules['pending_occurrences'], hasLength(1));
        expect(failureOf(jsonEncode(withRules)), isNull);
      });
      test('a v2 file without the recurring lists is corrupt', () {
        expect(
          problemOf(jsonEncode(copy()..remove('pending_occurrences'))),
          BackupProblem.corruptFile,
        );
      });
      test('a rule pointing at a missing account is corrupt', () {
        final broken = copy();
        ((broken['recurring_rules'] as List).first as Map)['account_id'] =
            'ghost';
        expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
      });
      test('a pending item pointing at a missing rule is corrupt', () {
        final broken = copy();
        ((broken['pending_occurrences'] as List).first as Map)['rule_id'] =
            'ghost';
        expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
      });
      test('a transaction pointing at a missing rule is corrupt', () {
        final broken = copy();
        (broken['recurring_rules'] as List).removeWhere(
          (r) => (r as Map)['id'] == 'rent',
        );
        expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
      });
      test('an unknown frequency is corrupt', () {
        final broken = copy();
        ((broken['recurring_rules'] as List).first as Map)['frequency'] =
            'hourly';
        expect(problemOf(jsonEncode(broken)), BackupProblem.corruptFile);
      });
    });
  });

  test('a v1 file (before recurring) still restores', () async {
    await seedRandomTransactions(
      db,
      count: 25,
      end: LocalDate(2026, 9, 29),
      seed: 3,
    );
    await addNotedTransfer();
    final before = await contents();
    // What the Phase 6 app wrote: schema 1, no recurring lists.
    final v1 = jsonDecode(await exportJson()) as Map<String, dynamic>
      ..['schema_version'] = 1
      ..remove('recurring_rules')
      ..remove('pending_occurrences');
    await addRecurring();

    final file = decode(jsonEncode(v1));
    expect(file.schemaVersion, 1);
    expect(file.recurringRules, isEmpty);
    expect((await repo.restore(file, RestoreMode.replace)).isRight(), isTrue);
    expect(await contents(), before);
  });

  test('restore result is Right(unit)', () async {
    final backup = decode(await exportJson());
    expect(
      await repo.restore(backup, RestoreMode.replace),
      const Right<Failure, Unit>(unit),
    );
  });
}
