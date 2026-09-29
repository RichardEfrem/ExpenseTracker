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
import 'package:flutter/rendering.dart';
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
    final cat = {
      for (final c in await db.select(db.categories).get()) c.name: c.id,
    };
    var n = 0;
    Future<void> add(String type, String date, int amount, String category) =>
        db
            .into(db.transactions)
            .insert(
              TransactionsCompanion.insert(
                id: 't${n++}',
                type: type,
                amount: amount,
                accountId: cash,
                categoryId: Value(cat[category]),
                date: date,
                time: '12:00',
                createdAt: n,
                updatedAt: n,
              ),
            );
    await add('income', '2026-09-01', 8500000, 'Salary');
    await add('expense', '2026-09-05', 1840000, 'Food & Drinks');
    await add('expense', '2026-09-06', 790000, 'Transport');
    await add('expense', '2026-09-07', 655000, 'Groceries');
    await add('expense', '2026-09-08', 100000, 'Health');
    await add('expense', '2026-08-10', 1000000, 'Shopping');
  }());

  Future<void> pumpApp(
    WidgetTester tester, {
    double textScale = 1,
    Size size = const Size(400, 1400),
    String location = '/',
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    router = createAppRouter(initialLocation: location);
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
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
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

  testWidgets('empty state before any transaction', (tester) async {
    await pumpApp(tester);
    expect(
      find.text(
        'No transactions yet. Add your first expense to see your month.',
      ),
      findsOneWidget,
    );
    expect(find.text('Add expense'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('shows net, income, expense, top spending and recent', (
    tester,
  ) async {
    await seed(tester);
    await pumpApp(tester);
    expect(find.text('Good afternoon'), findsOneWidget);
    expect(find.text('Net · September 2026'), findsOneWidget);
    expect(find.text('+Rp 5.115.000'), findsOneWidget);
    expect(find.text('Rp 8.500.000'), findsOneWidget);
    expect(find.text('Rp 3.385.000'), findsOneWidget);
    expect(
      find.text('▲ 238,5% vs Aug'),
      findsOneWidget,
      reason: 'expense vs 1.000.000',
    );
    // Top spending: 3 categories, largest first.
    final top = find.byKey(const ValueKey('top-spending'));
    for (final name in ['Food & Drinks', 'Transport', 'Groceries']) {
      expect(
        find.descendant(of: top, matching: find.text(name)),
        findsOneWidget,
      );
    }
    expect(
      find.descendant(of: top, matching: find.text('Health')),
      findsNothing,
    );
    expect(find.text('Health'), findsOneWidget, reason: 'in Recent');
    await dispose(tester);
  });

  testWidgets('reading order matches visual order', (tester) async {
    final handle = tester.ensureSemantics();
    await seed(tester);
    await pumpApp(tester);
    final nodes = <String>[];
    void visit(SemanticsNode node) {
      final label = node.label;
      if (label.isNotEmpty) nodes.add(label);
      node
          .debugListChildrenInOrder(DebugSemanticsDumpOrder.traversalOrder)
          .forEach(visit);
    }

    visit(tester.getSemantics(find.byType(Scaffold).first));
    int indexOf(String text) => nodes.indexWhere((l) => l.contains(text));
    final order = [
      indexOf('Good afternoon'),
      indexOf('Net · September 2026'),
      indexOf('Income'),
      indexOf('Expense'),
      indexOf('Top spending'),
      indexOf('Recent'),
    ];
    expect(order.every((i) => i >= 0), isTrue, reason: nodes.join(' | '));
    expect(order, [...order]..sort(), reason: nodes.join(' | '));
    handle.dispose();
    await dispose(tester);
  });

  testWidgets(
    'tapping Expense opens Activity filtered to expenses this month',
    (tester) async {
      await seed(tester);
      await pumpApp(tester);
      await tester.tap(find.byKey(const ValueKey('expense-card')));
      await settle(tester);
      final uri = router.state.uri;
      expect(uri.path, '/activity');
      expect(uri.queryParameters, {
        'type': 'expense',
        'from': '2026-09-01',
        'to': '2026-09-30',
      });
      expect(find.text('4 transactions · '), findsOneWidget);
      await dispose(tester);
    },
  );

  Future<void> addPending(WidgetTester tester, int count) =>
      pumpUntilDone(tester, () async {
        final cash = (await db.select(db.accounts).getSingle()).id;
        await db
            .into(db.recurringRules)
            .insert(
              RecurringRulesCompanion.insert(
                id: 'gym',
                type: 'expense',
                amount: 150000,
                accountId: cash,
                categoryId: Value(
                  (await db.select(db.categories).get()).first.id,
                ),
                frequency: 'weekly',
                startDate: '2026-09-15',
                autoCreate: const Value(false),
                createdAt: 1,
                updatedAt: 1,
              ),
            );
        for (var i = 0; i < count; i++) {
          await db
              .into(db.pendingOccurrences)
              .insert(
                PendingOccurrencesCompanion.insert(
                  id: 'p$i',
                  ruleId: 'gym',
                  date: '2026-09-${15 + 7 * i}',
                  createdAt: 1,
                ),
              );
        }
      }());

  testWidgets('no pending recurring items, no banner', (tester) async {
    await seed(tester);
    await pumpApp(tester);
    expect(find.byKey(const ValueKey('pending-recurring')), findsNothing);
    await dispose(tester);
  });

  testWidgets(
    'pending recurring items show a banner after income/expense → Review',
    (tester) async {
      await seed(tester);
      await addPending(tester, 2);
      await pumpApp(tester);
      expect(find.text('2 recurring items to confirm'), findsOneWidget);
      final banner = tester.getTopLeft(
        find.byKey(const ValueKey('pending-recurring')),
      );
      expect(
        banner.dy,
        greaterThan(
          tester.getTopLeft(find.byKey(const ValueKey('expense-card'))).dy,
        ),
      );
      expect(
        banner.dy,
        lessThan(
          tester.getTopLeft(find.byKey(const ValueKey('top-spending'))).dy,
        ),
      );
      await tester.tap(find.text('Review'));
      await settle(tester);
      expect(router.state.uri.path, '/more/recurring');
      expect(find.text('To confirm'), findsOneWidget);
      await dispose(tester);
    },
  );

  testWidgets('the banner shows even before the first transaction', (
    tester,
  ) async {
    await addPending(tester, 1);
    await pumpApp(tester);
    expect(find.text('1 recurring item to confirm'), findsOneWidget);
    expect(find.text('Add expense'), findsOneWidget);
    await dispose(tester);
  });

  for (final location in ['/', '/reports', '/activity']) {
    testWidgets('$location with data fits at 360 dp and 200% font', (
      tester,
    ) async {
      await seed(tester);
      await pumpApp(
        tester,
        textScale: 2,
        size: const Size(360, 720),
        location: location,
      );
      expect(tester.takeException(), isNull);
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -2000));
      await settle(tester);
      expect(tester.takeException(), isNull);
      await dispose(tester);
    });
  }
}
