import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/features/backup/backup/data/backup_providers.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_actions.g.dart';

/// Backup, restore and erase. Each returns its result for the page to show.
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
  Future<Either<Failure, BackupFile?>> pick() =>
      ref.read(previewBackupProvider)();

  Future<Failure?> restore(BackupFile file, RestoreMode mode) async =>
      (await ref.read(restoreBackupProvider)(
        file,
        mode,
      )).getLeft().toNullable();

  Future<Failure?> eraseAll() async =>
      (await ref.read(eraseAllDataProvider)()).getLeft().toNullable();
}
