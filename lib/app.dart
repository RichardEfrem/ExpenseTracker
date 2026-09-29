import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/features/lock/lock_presentation.dart';
import 'package:expense_tracker/features/recurring/recurring_presentation.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    // Due recurring occurrences are generated on app open and on every
    // return to the app; there is no background service (PRD REC-02).
    ref.read(recurringGenerationProvider);
    _lifecycle = AppLifecycleListener(
      // Leaving the app starts the lock timeout; coming back checks it.
      onHide: () => ref.read(appLockProvider.notifier).onHidden(),
      onResume: () {
        ref.read(appLockProvider.notifier).onResumed();
        ref.read(recurringGenerationProvider.notifier).run();
      },
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Locking and unlocking re-run the router's redirect (lock screen).
    ref.listen(
      appLockProvider.select((lock) => lock.value?.status),
      (_, _) => ref.read(appRouterProvider).refresh(),
    );
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).app_title,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: switch (ref.watch(appThemeModeProvider)) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
