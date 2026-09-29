import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_providers.g.dart';

@riverpod
ReportsLocalDataSource reportsLocalDataSource(Ref ref) =>
    ReportsLocalDataSource(ref.watch(appDatabaseProvider));
