import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/settings/presentation/pages/more_page.dart';
import 'package:expense_tracker/features/settings/presentation/pages/preferences_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes settingsRoutes() => ModuleRoutes(
  tab: StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppPaths.more,
        builder: (context, state) => const MorePage(),
      ),
    ],
  ),
  routes: [
    GoRoute(
      path: AppPaths.preferences,
      builder: (context, state) => const PreferencesPage(),
    ),
  ],
);
