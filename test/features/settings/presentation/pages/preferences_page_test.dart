import 'dart:async';

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/features/settings/data/models/app_settings_model.dart';
import 'package:expense_tracker/features/settings/presentation/pages/more_page.dart';
import 'package:expense_tracker/features/settings/presentation/pages/preferences_page.dart';
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

  Future<void> pump(WidgetTester tester, Widget page) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          appVersionProvider.overrideWith((ref) async => '1.0.0 (1)'),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: page,
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await pumpUntilDone(tester, db.close());
  }

  Future<Map<String, String>> stored(WidgetTester tester) async => {
    for (final row in await pumpUntilDone(tester, db.select(db.settings).get()))
      row.key: row.value,
  };

  testWidgets('More shows sections, unbuilt items disabled', (tester) async {
    await pump(tester, const MorePage());
    expect(find.text('Money'), findsOneWidget);
    expect(find.text('1.0.0 (1)'), findsOneWidget);
    final recurring = tester.widget<ListTile>(
      find.widgetWithText(ListTile, 'Recurring'),
    );
    expect(recurring.enabled, isFalse);
    expect(
      tester
          .widget<ListTile>(find.widgetWithText(ListTile, 'Categories'))
          .enabled,
      isTrue,
    );
    await dispose(tester);
  });

  testWidgets('choosing a theme persists it', (tester) async {
    await pump(tester, const PreferencesPage());
    await tester.tap(find.text('Theme'));
    await settle(tester);
    await tester.tap(find.text('Dark'));
    await settle(tester);
    expect((await stored(tester))[SettingsKeys.themeMode], 'dark');
    expect(find.text('Dark'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('choosing a month start day persists it', (tester) async {
    await pump(tester, const PreferencesPage());
    await tester.tap(find.text('Month start day'));
    await settle(tester);
    await tester.tap(find.bySemanticsLabel('Day 25'));
    await settle(tester);
    expect((await stored(tester))[SettingsKeys.monthStartDay], '25');
    expect(find.textContaining('Day 25'), findsOneWidget);
    await dispose(tester);
  });
}
