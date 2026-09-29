import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/categories/presentation/pages/categories_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes categoriesRoutes() => ModuleRoutes(
  routes: [
    GoRoute(
      path: AppPaths.categories,
      builder: (context, state) => const CategoriesPage(),
    ),
  ],
);
