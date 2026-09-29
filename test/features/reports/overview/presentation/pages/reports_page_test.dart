import 'dart:async';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Drift work is scheduled on the widget test's fake clock, so awaiting it
/// directly never completes: pump until [future] is done instead.
Future<T> pumpUntilDone<T>(WidgetTester tester, Future<T> future) async {
  late T result;
  Object? error;
  var done = false;
  unawaited(
    future.then(
      (value) {
        result = value;
        done = true;
      },
      onError: (Object e) {
        error = e;
        done = true;
      },
    ),
  );
  for (var i = 0; i < 100 && !done; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  if (error != null) throw error!;
  if (!done) fail('future did not complete');
  return result;
}

/// Lets queued drift writes and stream re-queries run, then settles frames.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
  await tester.pumpAndSettle();
}

void main() {
  late AppDatabase db;
  late GoRouter router;
  late Map<String, String> cat;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> seed(WidgetTester tester, {bool august = false}) =>
      pumpUntilDone(tester, () async {
        final cash = (await db.select(db.accounts).getSingle()).id;
        cat = {
          for (final c in await db.select(db.categories).get()) c.name: c.id,
        };
        Future<void> add(String id, String date, int amount, String category) =>
            db
                .into(db.transactions)
                .insert(
                  TransactionsCompanion.insert(
                    id: id,
                    type: 'expense',
                    amount: amount,
                    accountId: cash,
                    categoryId: Value(cat[category]),
                    date: date,
                    time: '12:00',
                    createdAt: 0,
                    updatedAt: 0,
                  ),
                );
        if (august) {
          await add('a', '2026-08-10', 50000, 'Food & Drinks');
        } else {
          await add('a', '2026-09-05', 45000, 'Food & Drinks');
          await add('b', '2026-09-06', 20000, 'Transport');
        }
      }());

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    router = createAppRouter(initialLocation: '/reports');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          clockProvider.overrideWithValue(
            FixedClock(DateTime(2026, 9, 29, 15)),
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    router.dispose();
    await pumpUntilDone(tester, db.close());
  }

  testWidgets('stat cards and the category breakdown', (tester) async {
    await seed(tester);
    await pumpApp(tester);
    expect(find.byKey(const ValueKey('stat-average')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('stat-savings')),
      findsNothing,
      reason: 'no income',
    );
    expect(find.text('Spending by category'), findsOneWidget);
    expect(find.text('Food & Drinks'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('a ranked category opens Activity filtered to it (SRCH-04)', (
    tester,
  ) async {
    await seed(tester);
    await pumpApp(tester);
    await tester.tap(find.text('Food & Drinks'));
    await settle(tester);
    expect(router.state.uri.path, '/activity');
    expect(router.state.uri.queryParameters, {
      'category': cat['Food & Drinks'],
      'from': '2026-09-01',
      'to': '2026-09-30',
    });
    await dispose(tester);
  });

  testWidgets('empty period offers the last month with data', (tester) async {
    await seed(tester, august: true);
    await pumpApp(tester);
    expect(find.text('No data for September 2026.'), findsOneWidget);
    await tester.tap(find.text('Go to last month with data'));
    await settle(tester);
    expect(find.text('August 2026'), findsOneWidget);
    expect(find.text('Food & Drinks'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('trends and daily tabs render', (tester) async {
    await seed(tester);
    await pumpApp(tester);
    await tester.tap(find.text('Trends'));
    await settle(tester);
    expect(find.text('Income vs expense'), findsOneWidget);
    await tester.tap(find.text('Daily'));
    await settle(tester);
    expect(find.text('Daily spending'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await dispose(tester);
  });
}
