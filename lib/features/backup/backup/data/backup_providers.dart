import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/repositories/backup_repository_impl.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/erase_all_data.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/export_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/preview_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/restore_backup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_providers.g.dart';

@riverpod
BackupLocalDataSource backupLocalDataSource(Ref ref) =>
    BackupLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
BackupFileDataSource backupFileDataSource(Ref ref) =>
    const BackupFileDataSource();

@riverpod
BackupRepository backupRepository(Ref ref) => BackupRepositoryImpl(
  ref.watch(backupLocalDataSourceProvider),
  ref.watch(backupFileDataSourceProvider),
  ref.watch(clockProvider),
);

@riverpod
ExportBackup exportBackup(Ref ref) =>
    ExportBackup(ref.watch(backupRepositoryProvider), ref.watch(clockProvider));

@riverpod
PreviewBackup previewBackup(Ref ref) =>
    PreviewBackup(ref.watch(backupRepositoryProvider));

@riverpod
RestoreBackup restoreBackup(Ref ref) =>
    RestoreBackup(ref.watch(backupRepositoryProvider));

@riverpod
EraseAllData eraseAllData(Ref ref) =>
    EraseAllData(ref.watch(backupRepositoryProvider));
