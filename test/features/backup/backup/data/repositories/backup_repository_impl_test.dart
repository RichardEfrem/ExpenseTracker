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
      await db.customStatement(
        "UPDATE categories SET is_archived = 1 WHERE name = 'Gift'",
      );
      final before = await contents();

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
    await repo.eraseAll();
    final r = await rows();
    expect(r.transactions, isEmpty);
    expect(r.categories, hasLength(14));
    expect(r.accounts.single.name, 'Cash');
    expect(r.settings, isEmpty);
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
        problemOf(jsonEncode({...valid, 'schema_version': 2})),
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
  });

  test('restore result is Right(unit)', () async {
    final backup = decode(await exportJson());
    expect(
      await repo.restore(backup, RestoreMode.replace),
      const Right<Failure, Unit>(unit),
    );
  });
}
