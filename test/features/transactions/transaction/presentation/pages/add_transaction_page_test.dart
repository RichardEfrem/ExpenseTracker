import 'dart:async';

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
  final now = DateTime(2026, 9, 29, 12, 30);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    router = createAppRouter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          clockProvider.overrideWithValue(FixedClock(now)),
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

  Future<void> typeKeys(WidgetTester tester, List<KeypadKey> keys) async {
    for (final key in keys) {
      await tester.tap(find.byKey(ValueKey(key)));
      await tester.pump();
    }
  }

  Future<List<TransactionRow>> rows(WidgetTester tester) =>
      pumpUntilDone(tester, db.select(db.transactions).get());

  testWidgets('add flow: FAB → 45000 → Food preselected → Save', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('add-fab')));
    await settle(tester);

    final save = find.byKey(const ValueKey('save'));
    expect(tester.widget<FilledButton>(save).onPressed, isNull);
    await typeKeys(tester, [
      KeypadKey.digit4,
      KeypadKey.digit5,
      KeypadKey.tripleZero,
    ]);
    expect(find.text('Rp 45.000'), findsOneWidget);
    final food = await pumpUntilDone(
      tester,
      (db.select(
        db.categories,
      )..where((c) => c.name.equals('Food & Drinks'))).getSingle(),
    );
    final foodCell = tester.widget<Semantics>(
      find
          .ancestor(
            of: find.byKey(ValueKey('category-${food.id}')),
            matching: find.byType(Semantics),
          )
          .first,
    );
    expect(foodCell.properties.selected, isTrue);

    await tester.tap(save);
    await settle(tester);

    final stored = await rows(tester);
    final cash = await pumpUntilDone(
      tester,
      db.select(db.accounts).getSingle(),
    );
    expect(stored, hasLength(1));
    expect(stored.single.amount, 45000);
    expect(stored.single.type, 'expense');
    expect(stored.single.categoryId, food.id);
    expect(stored.single.accountId, cash.id);
    expect(stored.single.date, '2026-09-29');
    expect(stored.single.time, '12:30');
    expect(find.byType(AmountKeypad), findsNothing, reason: 'screen closed');
    // On Home: in Top spending and in Recent.
    expect(find.text('Food & Drinks'), findsNWidgets(2));
    await dispose(tester);
  });

  testWidgets('arithmetic shows a live result', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('add-fab')));
    await settle(tester);
    await typeKeys(tester, [
      KeypadKey.digit2,
      KeypadKey.digit5,
      KeypadKey.tripleZero,
      KeypadKey.add,
      KeypadKey.digit1,
      KeypadKey.digit2,
      KeypadKey.digit5,
      KeypadKey.digit0,
      KeypadKey.digit0,
    ]);
    expect(find.text('25.000 + 12.500 = Rp 37.500'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('delete from the detail sheet, then undo restores the row', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const ValueKey('add-fab')));
    await settle(tester);
    await typeKeys(tester, [KeypadKey.digit9, KeypadKey.tripleZero]);
    await tester.tap(find.byKey(const ValueKey('save')));
    await settle(tester);
    final before = await rows(tester);

    // The Recent row (Top spending lists it first).
    await tester.tap(find.text('Food & Drinks').last);
    await settle(tester);
    await tester.tap(find.text('Delete'));
    await settle(tester);
    expect(await rows(tester), isEmpty);
    expect(find.text('Transaction deleted'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await settle(tester);
    expect(await rows(tester), before);
    await dispose(tester);
  });

  testWidgets('long-press FAB → Income adds income', (tester) async {
    await pumpApp(tester);
    await tester.longPress(find.byKey(const ValueKey('add-fab')));
    await settle(tester);
    await tester.tap(find.text('Income').last);
    await settle(tester);
    await typeKeys(tester, [KeypadKey.digit5, KeypadKey.tripleZero]);
    await tester.tap(find.byKey(const ValueKey('save')));
    await settle(tester);
    final stored = await rows(tester);
    expect(stored.single.type, 'income');
    await dispose(tester);
  });

  testWidgets('transfer between two accounts', (tester) async {
    await pumpUntilDone(
      tester,
      db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: 'bank',
              name: 'BCA',
              type: 'bank',
              icon: 'account_balance',
              color: 'blue',
              sortOrder: 1,
              createdAt: 0,
              updatedAt: 0,
            ),
          ),
    );
    await pumpApp(tester);
    await tester.longPress(find.byKey(const ValueKey('add-fab')));
    await settle(tester);
    await tester.tap(find.text('Transfer').last);
    await settle(tester);
    expect(find.byKey(const ValueKey('transfer-from')), findsOneWidget);
    expect(find.text('BCA'), findsOneWidget, reason: 'destination preselected');
    await typeKeys(tester, [
      KeypadKey.digit5,
      KeypadKey.tripleZero,
      KeypadKey.tripleZero,
    ]);
    await tester.tap(find.byKey(const ValueKey('save')));
    await settle(tester);
    final stored = (await rows(tester)).single;
    expect(stored.type, 'transfer');
    expect(stored.amount, 5000000);
    expect(stored.toAccountId, 'bank');
    expect(stored.categoryId, isNull);
    await dispose(tester);
  });
}
