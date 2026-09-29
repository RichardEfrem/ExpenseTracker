import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/recurring/presentation/pages/recurring_page.dart';
import 'package:expense_tracker/features/recurring/presentation/pages/recurring_rule_edit_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes recurringRoutes() => ModuleRoutes(
  routes: [
    GoRoute(
      path: AppPaths.recurring,
      builder: (context, state) => const RecurringPage(),
    ),
    GoRoute(
      path: AppPaths.newRecurring,
      builder: (context, state) => const RecurringRuleEditPage(),
    ),
    GoRoute(
      path: AppPaths.editRecurring,
      builder: (context, state) =>
          RecurringRuleEditPage(editId: state.pathParameters['id']),
    ),
  ],
);
