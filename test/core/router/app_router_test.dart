import 'dart:async';

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Drift work is scheduled on the widget test's fake clock, so awaiting it
/// directly never completes: pump until [future] is done instead.
Future<void> pumpUntilDone(WidgetTester tester, Future<void> future) async {
  var done = false;
  unawaited(future.whenComplete(() => done = true));
  for (var i = 0; i < 100 && !done; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
}

void main() {
  late GoRouter router;
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  List<Override> overrides() => [
    appDatabaseProvider.overrideWithValue(db),
    appVersionProvider.overrideWith((ref) async => '1.0.0 (1)'),
  ];

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await pumpUntilDone(tester, db.close());
  }

  Future<void> pumpApp(WidgetTester tester) async {
    router = createAppRouter();
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides(),
        child: MaterialApp.router(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  String location() =>
      router.routerDelegate.currentConfiguration.uri.toString();

  /// Includes pushed (imperative) routes, which [location] does not.
  String topLocation() =>
      router.routerDelegate.currentConfiguration.last.matchedLocation;
  int selectedTab(WidgetTester tester) =>
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex;
  Finder fab() => find.byType(FloatingActionButton);

  Future<void> tapTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> back(WidgetTester tester) async {
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
  }

  testWidgets('starts on Home with the FAB', (tester) async {
    await pumpApp(tester);
    expect(location(), AppPaths.home);
    expect(selectedTab(tester), 0);
    expect(fab(), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('tabs switch by path; FAB only on Home and Activity', (
    tester,
  ) async {
    await pumpApp(tester);
    for (final (label, path, index, hasFab) in [
      ('Activity', AppPaths.activity, 1, true),
      ('Reports', AppPaths.reports, 2, false),
      ('More', AppPaths.more, 3, false),
      ('Home', AppPaths.home, 0, true),
    ]) {
      await tapTab(tester, label);
      expect(location(), path);
      expect(selectedTab(tester), index);
      expect(fab(), hasFab ? findsOneWidget : findsNothing, reason: label);
    }
    await dispose(tester);
  });

  testWidgets('going to a path selects its tab', (tester) async {
    await pumpApp(tester);
    router.go(AppPaths.reports);
    await tester.pumpAndSettle();
    expect(selectedTab(tester), 2);
    expect(find.widgetWithText(AppBar, 'Reports'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('back from a tab root goes Home, then exits', (tester) async {
    await pumpApp(tester);
    await tapTab(tester, 'Reports');
    await back(tester);
    expect(location(), AppPaths.home);

    // At Home, back leaves the app: the router has nothing to pop.
    expect(router.canPop(), isFalse);
    await dispose(tester);
  });

  testWidgets('FAB opens the add screen for an expense', (tester) async {
    await pumpApp(tester);
    await tester.tap(fab());
    await tester.pumpAndSettle();
    expect(find.byType(AmountKeypad), findsOneWidget);
    expect(topLocation(), AppPaths.add);
    expect(find.byType(NavigationBar), findsNothing);

    await back(tester);
    expect(location(), AppPaths.home);
    await dispose(tester);
  });

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('every tab fits at 360 dp and 200% font (${mode.name})', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640) * 3;
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      router = createAppRouter();
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: overrides(),
          child: MaterialApp.router(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
          ),
        ),
      );
      for (final path in [...AppPaths.tabs, AppPaths.add]) {
        router.go(path);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: path);
      }
      await dispose(tester);
    });
  }

  test('tab paths and FAB tabs are consistent', () {
    expect(AppPaths.tabs.first, AppPaths.home);
    expect(AppPaths.tabs, containsAll(AppPaths.tabsWithFab));
  });
}
