import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/accounts/presentation/pages/accounts_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes accountsRoutes() => ModuleRoutes(
  routes: [
    GoRoute(
      path: AppPaths.accounts,
      builder: (context, state) => const AccountsPage(),
    ),
  ],
);
