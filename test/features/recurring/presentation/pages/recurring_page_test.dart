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

  /// Rent (auto, monthly on 25, generated through today) and Gym (asks
  /// first, weekly) with two items waiting.
  Future<void> seed(WidgetTester tester) => pumpUntilDone(tester, () async {
    final cash = (await db.select(db.accounts).getSingle()).id;
    final cat = {
      for (final c in await db.select(db.categories).get()) c.name: c.id,
    };
    Future<void> rule(
      String id, {
      required String note,
      required String frequency,
      required String start,
      required int amount,
      required bool auto,
      int? day,
    }) => db
        .into(db.recurringRules)
        .insert(
          RecurringRulesCompanion.insert(
            id: id,
            type: 'expense',
            amount: amount,
            accountId: cash,
            categoryId: Value(cat['Health']),
            note: Value(note),
            frequency: frequency,
            dayOfMonth: Value(day),
            startDate: start,
            autoCreate: Value(auto),
            lastGeneratedDate: const Value('2026-09-29'),
            createdAt: 1,
            updatedAt: 1,
          ),
        );
    await rule(
      'rent',
      note: 'Rent',
      frequency: 'monthly',
      start: '2026-07-25',
      amount: 3000000,
      auto: true,
      day: 25,
    );
    await rule(
      'gym',
      note: 'Gym',
      frequency: 'weekly',
      start: '2026-09-15',
      amount: 150000,
      auto: false,
    );
    for (final (id, date) in [('p1', '2026-09-15'), ('p2', '2026-09-22')]) {
      await db
          .into(db.pendingOccurrences)
          .insert(
            PendingOccurrencesCompanion.insert(
              id: id,
              ruleId: 'gym',
              date: date,
              createdAt: 2,
            ),
          );
    }
  }());

  Future<void> pumpApp(
    WidgetTester tester, {
    double textScale = 1,
    Size size = const Size(400, 900),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    router = createAppRouter(initialLocation: '/more');
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
    await tester.tap(find.text('Recurring'));
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    router.dispose();
    await pumpUntilDone(tester, db.close());
  }

  testWidgets('More → Recurring, empty state leads to a new rule', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(router.state.uri.path, '/more/recurring');
    expect(
      find.text(
        "Add rent, salary or subscriptions once and they'll appear "
        'automatically.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'New recurring'));
    await settle(tester);
    expect(router.state.uri.path, '/more/recurring/new');
    await dispose(tester);
  });

  testWidgets('pending items first, then rules with schedule and next date', (
    tester,
  ) async {
    await seed(tester);
    await pumpApp(tester);
    expect(find.text('To confirm'), findsOneWidget);
    expect(find.text('Due 15 Sep'), findsOneWidget);
    expect(find.text('Due 22 Sep'), findsOneWidget);
    expect(find.text('Rules'), findsOneWidget);
    expect(find.text('Weekly · Next 6 Oct 2026 · Asks first'), findsOneWidget);
    expect(find.text('Monthly on day 25 · Next 25 Oct 2026'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('To confirm')).dy,
      lessThan(tester.getTopLeft(find.text('Rules')).dy),
    );
    // Soonest next date first.
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('rule-gym'))).dy,
      lessThan(tester.getTopLeft(find.byKey(const ValueKey('rule-rent'))).dy),
    );
    await dispose(tester);
  });

  testWidgets('confirm adds the transaction on its due date', (tester) async {
    await seed(tester);
    await pumpApp(tester);
    await tester.tap(
      find.descendant(
        of: find.byKey(const ValueKey('pending-p1')),
        matching: find.text('Confirm'),
      ),
    );
    await settle(tester);
    expect(find.text('Added to your transactions'), findsOneWidget);
    expect(find.text('Due 15 Sep'), findsNothing);
    final t = await pumpUntilDone(
      tester,
      db.select(db.transactions).getSingle(),
    );
    expect(
      (t.date, t.amount, t.note, t.recurringRuleId),
      ('2026-09-15', 150000, 'Gym', 'gym'),
    );
    await dispose(tester);
  });

  testWidgets('skip drops the item without a transaction', (tester) async {
    await seed(tester);
    await pumpApp(tester);
    await tester.tap(
      find.descendant(
        of: find.byKey(const ValueKey('pending-p2')),
        matching: find.text('Skip'),
      ),
    );
    await settle(tester);
    expect(find.text('Skipped'), findsOneWidget);
    expect(find.text('Due 22 Sep'), findsNothing);
    expect(find.text('Due 15 Sep'), findsOneWidget);
    expect(
      await pumpUntilDone(tester, db.select(db.transactions).get()),
      isEmpty,
    );
    await dispose(tester);
  });

  testWidgets('tapping a rule opens it for editing', (tester) async {
    await seed(tester);
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('rule-rent')));
    await settle(tester);
    expect(router.state.uri.path, '/more/recurring/rent/edit');
    expect(find.text('Edit recurring'), findsOneWidget);
    expect(find.text('Rp 3.000.000'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('fits at 360 dp and 200% font', (tester) async {
    await seed(tester);
    await pumpApp(tester, textScale: 2, size: const Size(360, 720));
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -2000));
    await settle(tester);
    expect(tester.takeException(), isNull);
    await dispose(tester);
  });
}
