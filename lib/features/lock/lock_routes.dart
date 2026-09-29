import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/lock/presentation/pages/app_lock_settings_page.dart';
import 'package:expense_tracker/features/lock/presentation/pages/lock_page.dart';
import 'package:expense_tracker/features/lock/presentation/pages/pin_setup_page.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:expense_tracker/features/lock/presentation/providers/pin_entry_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes lockRoutes() => ModuleRoutes(
  // Every navigation passes the lock (PRD §6.4).
  redirect: (context, state) => lockRedirect(
    ProviderScope.containerOf(
      context,
      listen: false,
    ).read(appLockProvider).value?.status,
    state.uri,
  ),
  routes: [
    GoRoute(path: AppPaths.lock, builder: (context, state) => const LockPage()),
    GoRoute(
      path: AppPaths.appLock,
      builder: (context, state) => const AppLockSettingsPage(),
    ),
    GoRoute(
      path: AppPaths.pinSetup,
      builder: (context, state) => PinSetupPage(
        mode:
            PinSetupMode.values
                .asNameMap()[state.uri.queryParameters['mode']] ??
            PinSetupMode.enable,
      ),
    ),
  ],
);
