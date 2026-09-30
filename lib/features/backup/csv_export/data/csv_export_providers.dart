import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/backup/backup/data/backup_providers.dart';
import 'package:expense_tracker/features/backup/csv_export/data/datasources/csv_export_local_datasource.dart';
import 'package:expense_tracker/features/backup/csv_export/data/repositories/csv_export_repository_impl.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/repositories/csv_export_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/usecases/export_csv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'csv_export_providers.g.dart';

@riverpod
CsvExportLocalDataSource csvExportLocalDataSource(Ref ref) =>
    CsvExportLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
CsvExportRepository csvExportRepository(Ref ref) => CsvExportRepositoryImpl(
  ref.watch(csvExportLocalDataSourceProvider),
  ref.watch(backupFileDataSourceProvider),
);

@riverpod
ExportCsv exportCsv(Ref ref) =>
    ExportCsv(ref.watch(csvExportRepositoryProvider));
