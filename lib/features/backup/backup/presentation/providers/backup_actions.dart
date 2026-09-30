import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/features/backup/backup/data/backup_providers.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/picked_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/presentation/providers/backup_status_notifiers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_actions.g.dart';

/// Backup, restore, erase and backup preferences. Each returns its result
/// for the page to show; the watched status updates itself.
@riverpod
class BackupActions extends _$BackupActions {
  @override
  void build() {}

  /// Right(true) when delivered, Right(false) when the user cancelled.
  Future<Either<Failure, bool>> export(ExportTarget target) async {
    final exporter = ref.read(exportBackupProvider);
    final version = await ref.read(appVersionProvider.future);
    return exporter(appVersion: version, target: target);
  }

  /// Right(null) when the user cancelled the picker.
  Future<Either<Failure, PickedBackup?>> pick() =>
      ref.read(previewBackupProvider)();

  Future<Either<Failure, BackupFile>> unlock(
    LockedBackup backup,
    String password,
  ) => ref.read(unlockBackupProvider)(backup, password);

  Future<Failure?> restore(BackupFile file, RestoreMode mode) async =>
      (await ref.read(restoreBackupProvider)(file, mode)).failureOrNull;

  Future<Failure?> eraseAll() async =>
      (await ref.read(eraseAllDataProvider)()).failureOrNull;

  Future<Failure?> setReminder({required bool enabled}) async =>
      (await ref.read(setBackupReminderProvider)(
        enabled: enabled,
      )).failureOrNull;

  Future<Failure?> snoozeReminder() async =>
      (await ref.read(snoozeBackupReminderProvider)()).failureOrNull;

  /// Right(false) when the user cancelled. A new folder gets its first
  /// backup right away.
  Future<Either<Failure, bool>> chooseAutoBackupFolder() async {
    final chosen = await ref.read(chooseAutoBackupFolderProvider)();
    if (chosen.getOrElse((_) => false)) {
      await ref.read(autoBackupRunnerProvider.notifier).run();
    }
    return chosen;
  }

  Future<Failure?> turnOffAutoBackup() async =>
      (await ref.read(turnOffAutoBackupProvider)()).failureOrNull;
}
