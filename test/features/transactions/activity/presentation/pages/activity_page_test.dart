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

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> seed(WidgetTester tester) => pumpUntilDone(tester, () async {
    final cash = (await db.select(db.accounts).getSingle()).id;
    final categories = {
      for (final c in await db.select(db.categories).get()) c.name: c.id,
    };
    Future<void> add(
      String id,
      String date,
      int amount,
      String category, {
      String? note,
    }) => db
        .into(db.transactions)
        .insert(
          TransactionsCompanion.insert(
            id: id,
            type: 'expense',
            amount: amount,
            accountId: cash,
            categoryId: Value(categories[category]),
            date: date,
            time: '12:00',
            note: Value(note),
            createdAt: 0,
            updatedAt: 0,
          ),
        );
    await add('a', '2026-09-29', 45000, 'Food & Drinks', note: 'Lunch');
    await add('b', '2026-09-28', 20000, 'Transport');
    await add('c', '2026-08-15', 99000, 'Shopping');
  }());

  Future<void> pumpApp(WidgetTester tester, String location) async {
    tester.view.physicalSize = const Size(400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    router = createAppRouter(initialLocation: location);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          clockProvider.overrideWithValue(
            FixedClock(DateTime(2026, 9, 29, 18)),
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

  testWidgets('day headers, month totals, and older months on scroll', (
    tester,
  ) async {
    await seed(tester);
    await pumpApp(tester, '/activity');
    expect(find.text('September 2026'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text('−Rp 65.000'), findsOneWidget, reason: 'Out total');
    // The list is short, so August loads on its own.
    expect(find.text('August 2026'), findsOneWidget);
    expect(find.text('Shopping'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('› is disabled on the current period', (tester) async {
    await pumpApp(tester, '/activity');
    IconButton next() =>
        tester.widget(find.byKey(const ValueKey('period-next')));
    expect(next().onPressed, isNull);
    await tester.tap(find.byKey(const ValueKey('period-previous')));
    await settle(tester);
    expect(find.text('August 2026'), findsWidgets);
    expect(next().onPressed, isNotNull);
    await dispose(tester);
  });

  testWidgets('swipe left deletes with undo', (tester) async {
    await seed(tester);
    await pumpApp(tester, '/activity');
    await tester.drag(find.text('Transport'), const Offset(-600, 0));
    await settle(tester);
    expect(find.text('Transport'), findsNothing);
    expect(
      await pumpUntilDone(
        tester,
        (db.select(db.transactions)..where((t) => t.id.equals('b'))).get(),
      ),
      isEmpty,
    );
    await tester.tap(find.text('Undo'));
    await settle(tester);
    expect(find.text('Transport'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('swipe right duplicates', (tester) async {
    await seed(tester);
    await pumpApp(tester, '/activity');
    await tester.drag(find.text('Transport'), const Offset(600, 0));
    await settle(tester);
    expect(find.text('Transport'), findsNWidgets(2));
    await dispose(tester);
  });

  testWidgets('a filtered URL opens a filtered list with a result bar', (
    tester,
  ) async {
    await seed(tester);
    await pumpApp(tester, '/activity?q=lunch');
    expect(find.byKey(const ValueKey('result-bar')), findsOneWidget);
    expect(find.text('1 transaction · '), findsOneWidget);
    expect(find.text('Food & Drinks'), findsOneWidget);
    expect(find.text('Transport'), findsNothing);
    await dispose(tester);
  });

  testWidgets('no match → clear filters', (tester) async {
    await seed(tester);
    await pumpApp(tester, '/activity?q=zzz');
    expect(find.text('Nothing matches these filters.'), findsOneWidget);
    await tester.tap(find.text('Clear filters'));
    await settle(tester);
    expect(find.text('Food & Drinks'), findsOneWidget);
    await dispose(tester);
  });
}
