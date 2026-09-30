import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/features/backup/backup/data/backup_providers.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/auto_backup.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backup_status_notifiers.g.dart';

/// Last backup, reminder and auto-backup state; updates itself.
@riverpod
class BackupStatusNotifier extends _$BackupStatusNotifier {
  @override
  Stream<BackupStatus> build() =>
      ref.watch(watchBackupStatusProvider)().unwrap();
}

/// Whether new backups are encrypted with a password (PRD BAK-03).
@riverpod
class BackupEncryption extends _$BackupEncryption {
  @override
  Future<bool> build() async =>
      (await ref.read(getBackupEncryptionProvider)()).getOrThrow();

  /// Null turns encryption off.
  Future<Failure?> setPassword(String? password) async {
    final failure = (await ref.read(setBackupPasswordProvider)(
      password,
    )).failureOrNull;
    if (failure == null && ref.mounted) state = AsyncData(password != null);
    return failure;
  }
}

/// Writes the weekly auto-backup when due (PRD BAK-05). Runs when the app
/// first listens (app open) and again on [run] (resume, or a new folder).
@Riverpod(keepAlive: true)
class AutoBackupRunner extends _$AutoBackupRunner {
  @override
  Future<AutoBackupOutcome> build() => _attempt();

  Future<AutoBackupOutcome> _attempt() async {
    final version = await ref.read(appVersionProvider.future);
    return (await ref.read(runAutoBackupProvider)(
      appVersion: version,
    )).getOrThrow();
  }

  Future<void> run() async {
    // One at a time: a resume during a slow write shouldn't start another.
    if (state.isLoading) return;
    state = const AsyncLoading<AutoBackupOutcome>();
    final next = await AsyncValue.guard(_attempt);
    if (ref.mounted) state = next;
  }
}
