import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/reports/overview/presentation/pages/reports_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes reportsRoutes() => ModuleRoutes(
  tab: StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppPaths.reports,
        builder: (context, state) => const ReportsPage(),
      ),
    ],
  ),
);
