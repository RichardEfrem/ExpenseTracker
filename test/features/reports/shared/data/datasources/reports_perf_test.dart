@Tags(['perf'])
library;

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/trends/domain/usecases/watch_trends.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every report query within budget: ≤ 500 ms at 10k rows, ≤ 1.5 s at
/// 100k (PRD §8).
void main() {
  final today = LocalDate(2026, 9, 29);
  final month = ReportScope(period: Period.monthContaining(today));
  final year = ReportScope(period: Period.yearContaining(today));

  for (final (rows, budget) in [
    (10000, const Duration(milliseconds: 500)),
    (100000, const Duration(milliseconds: 1500)),
  ]) {
    group('$rows rows', () {
      late AppDatabase db;
      late ReportsLocalDataSource source;

      setUpAll(() async {
        db = AppDatabase(NativeDatabase.memory());
        await seedRandomTransactions(db, count: rows, end: today);
        source = ReportsLocalDataSource(db);
      });
      tearDownAll(() => db.close());

      final queries =
          <String, Future<Object?> Function(ReportsLocalDataSource)>{
            'totals': (s) => s.totals(year),
            'by category': (s) => s.byCategory(year, 'expense'),
            'by 12 months': (s) => s.byPeriods(
              WatchTrends.monthsEnding(month.period, 12, 1),
              const {},
            ),
            'daily': (s) => s.dailyExpense(year),
            'largest': (s) => s.largestExpense(year),
            'most frequent': (s) => s.mostFrequentCategory(year),
            'expense days': (s) => s.expenseDayCount(year, today),
            'category trend, 12 months': (s) => s.byCategoryPerPeriod(
              WatchTrends.monthsEnding(month.period, 12, 1),
              const {},
            ),
            'compare with previous year': (s) => s.byCategoryPerPeriod(
              [year.previous.period, year.period],
              const {},
              type: 'expense',
            ),
            'daily net (calendar)': (s) => s.dailyNet(year),
          };
      for (final MapEntry(key: name, value: query) in queries.entries) {
        test(name, () async {
          await query(source);
          final watch = Stopwatch()..start();
          await query(source);
          expect(watch.elapsed, lessThan(budget));
        });
      }
    });
  }
}
