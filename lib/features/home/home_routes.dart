import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes homeRoutes() => ModuleRoutes(
  tab: StatefulShellBranch(
    routes: [
      GoRoute(
        path: AppPaths.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  ),
);
