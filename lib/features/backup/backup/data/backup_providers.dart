import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_cipher.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_folder_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_secret_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/repositories/backup_repository_impl.dart';
import 'package:expense_tracker/features/backup/backup/data/repositories/backup_settings_repository_impl.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/auto_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/backup_preferences.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/encode_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/erase_all_data.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/export_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/preview_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/restore_backup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_providers.g.dart';

@riverpod
BackupLocalDataSource backupLocalDataSource(Ref ref) =>
    BackupLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
BackupFileDataSource backupFileDataSource(Ref ref) =>
    const BackupFileDataSource();

@riverpod
BackupFolderDataSource backupFolderDataSource(Ref ref) =>
    const BackupFolderDataSource();

@riverpod
BackupSecretDataSource backupSecretDataSource(Ref ref) =>
    const BackupSecretDataSource(FlutterSecureStorage());

@riverpod
BackupCipher backupCipher(Ref ref) => const BackupCipher();

@riverpod
BackupRepository backupRepository(Ref ref) => BackupRepositoryImpl(
  ref.watch(backupLocalDataSourceProvider),
  ref.watch(backupFileDataSourceProvider),
  ref.watch(clockProvider),
  cipher: ref.watch(backupCipherProvider),
  folders: ref.watch(backupFolderDataSourceProvider),
);

@riverpod
BackupSettingsRepository backupSettingsRepository(Ref ref) =>
    BackupSettingsRepositoryImpl(
      ref.watch(backupLocalDataSourceProvider),
      ref.watch(backupSecretDataSourceProvider),
    );

@riverpod
EncodeBackup encodeBackup(Ref ref) => EncodeBackup(
  ref.watch(backupRepositoryProvider),
  ref.watch(backupSettingsRepositoryProvider),
);

@riverpod
ExportBackup exportBackup(Ref ref) => ExportBackup(
  ref.watch(backupRepositoryProvider),
  ref.watch(encodeBackupProvider),
  ref.watch(clockProvider),
);

@riverpod
PreviewBackup previewBackup(Ref ref) =>
    PreviewBackup(ref.watch(backupRepositoryProvider));

@riverpod
UnlockBackup unlockBackup(Ref ref) =>
    UnlockBackup(ref.watch(backupRepositoryProvider));

@riverpod
RestoreBackup restoreBackup(Ref ref) =>
    RestoreBackup(ref.watch(backupRepositoryProvider));

@riverpod
EraseAllData eraseAllData(Ref ref) =>
    EraseAllData(ref.watch(backupRepositoryProvider));

@riverpod
WatchBackupStatus watchBackupStatus(Ref ref) =>
    WatchBackupStatus(ref.watch(backupSettingsRepositoryProvider));

@riverpod
SetBackupReminder setBackupReminder(Ref ref) =>
    SetBackupReminder(ref.watch(backupSettingsRepositoryProvider));

@riverpod
SnoozeBackupReminder snoozeBackupReminder(Ref ref) => SnoozeBackupReminder(
  ref.watch(backupSettingsRepositoryProvider),
  ref.watch(clockProvider),
);

@riverpod
GetBackupEncryption getBackupEncryption(Ref ref) =>
    GetBackupEncryption(ref.watch(backupSettingsRepositoryProvider));

@riverpod
SetBackupPassword setBackupPassword(Ref ref) =>
    SetBackupPassword(ref.watch(backupSettingsRepositoryProvider));

@riverpod
ChooseAutoBackupFolder chooseAutoBackupFolder(Ref ref) =>
    ChooseAutoBackupFolder(
      ref.watch(backupRepositoryProvider),
      ref.watch(backupSettingsRepositoryProvider),
    );

@riverpod
TurnOffAutoBackup turnOffAutoBackup(Ref ref) => TurnOffAutoBackup(
  ref.watch(backupRepositoryProvider),
  ref.watch(backupSettingsRepositoryProvider),
);

@riverpod
RunAutoBackup runAutoBackup(Ref ref) => RunAutoBackup(
  ref.watch(backupRepositoryProvider),
  ref.watch(backupSettingsRepositoryProvider),
  ref.watch(encodeBackupProvider),
  ref.watch(clockProvider),
);
