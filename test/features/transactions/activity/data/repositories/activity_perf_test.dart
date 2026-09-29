@Tags(['perf'])
library;

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/activity/data/datasources/activity_local_datasource.dart';
import 'package:expense_tracker/features/transactions/activity/data/repositories/activity_repository_impl.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

/// Activity queries at 10k transactions stay well inside the 500 ms report
/// budget (PRD §8).
void main() {
  late AppDatabase db;
  late ActivityRepositoryImpl repo;
  final today = LocalDate(2026, 9, 29);

  setUpAll(() async {
    db = AppDatabase(NativeDatabase.memory());
    await seedRandomTransactions(db, count: 10000, end: today);
    repo = ActivityRepositoryImpl(
      ActivityLocalDataSource(db, TransactionLocalDataSource(db)),
    );
  });
  tearDownAll(() => db.close());

  Future<Duration> time(Future<void> Function() body) async {
    await body(); // warm up
    final watch = Stopwatch()..start();
    await body();
    return watch.elapsed;
  }

  test('month page at 10k rows', () async {
    final elapsed = await time(
      () => repo
          .watchPage(TransactionFilter.none, Period.monthContaining(today))
          .first,
    );
    expect(elapsed, lessThan(const Duration(milliseconds: 500)));
  });

  test('filter summary with text search at 10k rows', () async {
    final elapsed = await time(
      () => repo
          .watchSummary(
            const TransactionFilter(text: 'coffee', minAmount: 10000),
          )
          .first,
    );
    expect(elapsed, lessThan(const Duration(milliseconds: 500)));
  });
}
