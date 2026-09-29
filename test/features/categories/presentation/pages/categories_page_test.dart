import 'dart:async';

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/features/categories/presentation/pages/categories_page.dart';
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

  Future<void> pumpPage(WidgetTester tester, {double textScale = 1}) async {
    if (textScale == 1) {
      tester.view.physicalSize = const Size(400, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(textScale)),
            child: child!,
          ),
          home: const CategoriesPage(),
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await pumpUntilDone(tester, db.close());
  }

  testWidgets('lists expense categories, switches to income', (tester) async {
    await pumpPage(tester);
    expect(find.text('Food & Drinks'), findsOneWidget);
    expect(find.text('No transactions'), findsWidgets);

    await tester.tap(find.text('Income'));
    await settle(tester);
    expect(find.text('Salary'), findsOneWidget);
    expect(find.text('Food & Drinks'), findsNothing);
    await dispose(tester);
  });

  testWidgets('create a category from the sheet', (tester) async {
    await pumpPage(tester);
    await tester.tap(find.byTooltip('New category'));
    await settle(tester);

    final save = find.byKey(const ValueKey('category-save'));
    expect(tester.widget<FilledButton>(save).onPressed, isNull);
    await tester.enterText(
      find.byKey(const ValueKey('category-name')),
      'Coffee',
    );
    await tester.pump();
    await tester.ensureVisible(save);
    await tester.tap(save);
    await settle(tester);

    expect(find.text('Coffee'), findsOneWidget);
    final rows = await pumpUntilDone(tester, db.select(db.categories).get());
    expect(rows.where((r) => r.name == 'Coffee').single.type, 'expense');
    await dispose(tester);
  });

  testWidgets('archive moves a category into the Archived section', (
    tester,
  ) async {
    await pumpPage(tester);
    await tester.tap(find.byTooltip('Show menu').first);
    await settle(tester);
    await tester.tap(find.text('Archive'));
    await settle(tester);

    expect(find.text('Archived (1)'), findsOneWidget);
    await tester.tap(find.text('Archived (1)'));
    await settle(tester);
    expect(find.text('Food & Drinks'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('fits at 360 dp and 200% font', (tester) async {
    tester.view.physicalSize = const Size(360, 720) * 3;
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await pumpPage(tester, textScale: 2);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byTooltip('New category'));
    await settle(tester);
    expect(tester.takeException(), isNull);
    await dispose(tester);
  });
}
