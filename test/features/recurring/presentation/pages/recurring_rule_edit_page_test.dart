import 'dart:async';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
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

  Future<void> pumpApp(
    WidgetTester tester, {
    double textScale = 1,
    Size size = const Size(400, 1000),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    router = createAppRouter(initialLocation: '/more/recurring');
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

  Future<void> openNew(WidgetTester tester) async {
    await tester.tap(find.byTooltip('New recurring'));
    await settle(tester);
  }

  Future<void> typeKeys(WidgetTester tester, List<KeypadKey> keys) async {
    for (final key in keys) {
      await tester.tap(find.byKey(ValueKey(key)));
      await tester.pump();
    }
  }

  Future<void> typeRent(WidgetTester tester) => typeKeys(tester, [
    KeypadKey.digit3,
    KeypadKey.tripleZero,
    KeypadKey.tripleZero,
  ]);

  Future<void> save(WidgetTester tester) async {
    await tester.ensureVisible(find.byKey(const ValueKey('save')));
    await tester.tap(find.byKey(const ValueKey('save')));
    await settle(tester);
  }

  Future<RecurringRuleRow> storedRule(WidgetTester tester) =>
      pumpUntilDone(tester, db.select(db.recurringRules).getSingle());

  Future<List<TransactionRow>> transactions(WidgetTester tester) =>
      pumpUntilDone(tester, db.select(db.transactions).get());

  testWidgets('new monthly rule from today is saved and generated at once', (
    tester,
  ) async {
    await pumpApp(tester);
    await openNew(tester);
    final saveButton = find.byKey(const ValueKey('save'));
    expect(tester.widget<FilledButton>(saveButton).onPressed, isNull);
    expect(find.text('Monthly on day 29'), findsOneWidget);
    expect(find.text('Starts 29 Sep 2026'), findsOneWidget);
    expect(find.text('No end date'), findsOneWidget);

    await typeRent(tester);
    expect(find.text('Rp 3.000.000'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('note-chip')));
    await settle(tester);
    await tester.enterText(find.byKey(const ValueKey('note-field')), 'Rent');
    await tester.tap(find.text('Done'));
    await settle(tester);
    await save(tester);

    expect(router.state.uri.path, '/more/recurring');
    expect(find.text('Recurring saved'), findsOneWidget);
    expect(find.text('Rent'), findsOneWidget);
    expect(find.text('Monthly on day 29 · Next 29 Oct 2026'), findsOneWidget);

    final rule = await storedRule(tester);
    expect(
      (
        rule.type,
        rule.amount,
        rule.note,
        rule.frequency,
        rule.interval,
        rule.dayOfMonth,
        rule.startDate,
        rule.endDate,
        rule.autoCreate,
        rule.lastGeneratedDate,
      ),
      (
        'expense',
        3000000,
        'Rent',
        'monthly',
        1,
        29,
        '2026-09-29',
        null,
        true,
        '2026-09-29',
      ),
    );
    final generated = await transactions(tester);
    expect(generated, hasLength(1));
    expect(
      (generated.single.date, generated.single.recurringRuleId),
      ('2026-09-29', rule.id),
    );
    await dispose(tester);
  });

  testWidgets('Repeat sheet: weekly every 2 weeks', (tester) async {
    await pumpApp(tester);
    await openNew(tester);
    await typeRent(tester);
    await tester.tap(find.byKey(const ValueKey('repeat-chip')));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('frequency-weekly')));
    await tester.pump();
    expect(find.byKey(const ValueKey('day-more')), findsNothing);
    final less = find.byKey(const ValueKey('interval-less'));
    expect(tester.widget<IconButton>(less).onPressed, isNull);
    await tester.tap(find.byKey(const ValueKey('interval-more')));
    await tester.pump();
    expect(find.text('Every 2 weeks'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('repeat-done')));
    await settle(tester);
    expect(find.text('Every 2 weeks'), findsOneWidget, reason: 'on the chip');
    await save(tester);

    final rule = await storedRule(tester);
    expect(
      (rule.frequency, rule.interval, rule.dayOfMonth),
      ('weekly', 2, null),
    );
    await dispose(tester);
  });

  testWidgets('Repeat sheet: monthly on day 31', (tester) async {
    await pumpApp(tester);
    await openNew(tester);
    await typeRent(tester);
    await tester.tap(find.byKey(const ValueKey('repeat-chip')));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('day-more')));
    await tester.tap(find.byKey(const ValueKey('day-more')));
    await tester.pump();
    expect(find.text('Day 31'), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(find.byKey(const ValueKey('day-more')))
          .onPressed,
      isNull,
    );
    await tester.tap(find.byKey(const ValueKey('repeat-done')));
    await settle(tester);
    expect(find.text('Monthly on day 31'), findsOneWidget);
    await save(tester);

    expect((await storedRule(tester)).dayOfMonth, 31);
    expect(
      await transactions(tester),
      isEmpty,
      reason: 'first occurrence is 30 Sep',
    );
    await dispose(tester);
  });

  testWidgets('"Ask before adding" queues the first item instead', (
    tester,
  ) async {
    await pumpApp(tester);
    await openNew(tester);
    await typeRent(tester);
    await tester.tap(find.byKey(const ValueKey('ask-first')));
    await tester.pump();
    await save(tester);

    expect((await storedRule(tester)).autoCreate, isFalse);
    expect(await transactions(tester), isEmpty);
    expect(find.text('To confirm'), findsOneWidget);
    expect(find.text('Due 29 Sep'), findsOneWidget);
    await dispose(tester);
  });

  Future<void> seedRule(WidgetTester tester) => pumpUntilDone(tester, () async {
    final cash = (await db.select(db.accounts).getSingle()).id;
    final health = (await (db.select(
      db.categories,
    )..where((c) => c.name.equals('Health'))).getSingle()).id;
    await db
        .into(db.recurringRules)
        .insert(
          RecurringRulesCompanion.insert(
            id: 'rent',
            type: 'expense',
            amount: 3000000,
            accountId: cash,
            categoryId: Value(health),
            note: const Value('Rent'),
            frequency: 'monthly',
            dayOfMonth: const Value(25),
            startDate: '2026-07-25',
            lastGeneratedDate: const Value('2026-09-29'),
            createdAt: 1,
            updatedAt: 1,
          ),
        );
  }());

  testWidgets('edit keeps generation state and changes the amount', (
    tester,
  ) async {
    await seedRule(tester);
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('rule-rent')));
    await settle(tester);
    expect(find.text('Rp 3.000.000'), findsOneWidget);
    expect(find.text('Monthly on day 25'), findsOneWidget);
    expect(find.text('Starts 25 Jul 2026'), findsOneWidget);
    // Long-press backspace clears.
    await tester.longPress(find.byKey(const ValueKey(KeypadKey.backspace)));
    await tester.pump();
    await typeKeys(tester, [
      KeypadKey.digit3,
      KeypadKey.digit5,
      KeypadKey.digit0,
      KeypadKey.digit0,
      KeypadKey.tripleZero,
    ]);
    await save(tester);

    final rule = await storedRule(tester);
    expect(
      (rule.amount, rule.dayOfMonth, rule.lastGeneratedDate),
      (3500000, 25, '2026-09-29'),
    );
    expect(await transactions(tester), isEmpty, reason: 'nothing new is due');
    await dispose(tester);
  });

  testWidgets('delete asks first, then removes the rule', (tester) async {
    await seedRule(tester);
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('rule-rent')));
    await settle(tester);
    await tester.tap(find.byTooltip('Delete'));
    await settle(tester);
    expect(find.text('Delete this rule?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await settle(tester);
    expect(router.state.uri.path, '/more/recurring');
    expect(find.text('Rule deleted'), findsOneWidget);
    expect(
      await pumpUntilDone(tester, db.select(db.recurringRules).get()),
      isEmpty,
    );
    await dispose(tester);
  });

  testWidgets('editor and Repeat sheet fit at 360 dp and 200% font', (
    tester,
  ) async {
    await pumpApp(tester, textScale: 2, size: const Size(360, 720));
    await openNew(tester);
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -2000));
    await settle(tester);
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, 2000));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('repeat-chip')));
    await settle(tester);
    expect(tester.takeException(), isNull);
    await dispose(tester);
  });
}
