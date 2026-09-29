import 'dart:async';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/accounts/presentation/pages/accounts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  Future<void> pumpPage(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await pumpUntilDone(tester, () async {
      final cash = (await db.select(db.accounts).getSingle()).id;
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              id: 'bank',
              name: 'BCA',
              type: 'bank',
              icon: 'account_balance',
              color: 'blue',
              openingBalance: const Value(1000000),
              sortOrder: 1,
              createdAt: 0,
              updatedAt: 0,
            ),
          );
      await db
          .into(db.transactions)
          .insert(
            TransactionsCompanion.insert(
              id: 't',
              type: 'transfer',
              amount: 250000,
              accountId: 'bank',
              toAccountId: Value(cash),
              date: '2026-09-10',
              time: '12:00',
              createdAt: 0,
              updatedAt: 0,
            ),
          );
    }());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          clockProvider.overrideWithValue(
            FixedClock(DateTime(2026, 9, 29, 12)),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AccountsPage(),
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await pumpUntilDone(tester, db.close());
  }

  testWidgets('balances, total and chart', (tester) async {
    await pumpPage(tester);
    expect(find.text('Rp 1.000.000'), findsOneWidget, reason: 'total');
    expect(find.text('Rp 250.000'), findsOneWidget, reason: 'Cash');
    expect(find.text('Rp 750.000'), findsOneWidget, reason: 'BCA');
    expect(find.text('Balance over time'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('adjust balance to the real amount', (tester) async {
    await pumpPage(tester);
    await tester.tap(find.byTooltip('Show menu').first);
    await settle(tester);
    await tester.tap(find.text('Adjust balance'));
    await settle(tester);
    await tester.enterText(
      find.byKey(const ValueKey('adjust-field')),
      '300000',
    );
    await tester.tap(find.byKey(const ValueKey('adjust-save')));
    await settle(tester);
    expect(find.text('Adjusted by +Rp 50.000'), findsOneWidget);
    expect(find.text('Rp 300.000'), findsOneWidget);
    await dispose(tester);
  });
}
