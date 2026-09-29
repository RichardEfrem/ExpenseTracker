import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/app_shell.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/accounts/accounts_routes.dart';
import 'package:expense_tracker/features/backup/backup_routes.dart';
import 'package:expense_tracker/features/categories/categories_routes.dart';
import 'package:expense_tracker/features/home/home_routes.dart';
import 'package:expense_tracker/features/period/period_routes.dart';
import 'package:expense_tracker/features/recurring/recurring_routes.dart';
import 'package:expense_tracker/features/reports/reports_routes.dart';
import 'package:expense_tracker/features/settings/settings_routes.dart';
import 'package:expense_tracker/features/transactions/transactions_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Each module once. Tabs appear in this order, which must match
/// [AppPaths.tabs].
List<ModuleRoutes> _modules() => [
  homeRoutes(),
  transactionsRoutes(),
  reportsRoutes(),
  settingsRoutes(),
  categoriesRoutes(),
  accountsRoutes(),
  recurringRoutes(),
  periodRoutes(),
  backupRoutes(),
];

GoRouter createAppRouter({String initialLocation = AppPaths.home}) {
  final modules = _modules();
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            AppShell(location: state.uri.path, child: shell),
        branches: [for (final module in modules) ?module.tab],
      ),
      for (final module in modules) ...module.routes,
    ],
  );
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = createAppRouter();
  ref.onDispose(router.dispose);
  return router;
}
