import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/backup/backup/presentation/pages/backup_page.dart';
import 'package:expense_tracker/features/backup/csv_export/presentation/pages/csv_export_page.dart';
import 'package:go_router/go_router.dart';

ModuleRoutes backupRoutes() => ModuleRoutes(
  routes: [
    GoRoute(
      path: AppPaths.backup,
      builder: (context, state) => const BackupPage(),
    ),
    GoRoute(
      path: AppPaths.csvExport,
      builder: (context, state) => const CsvExportPage(),
    ),
  ],
);
