import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/encode_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/export_backup.dart';
import 'package:fpdart/fpdart.dart';

/// Asks for a folder and turns weekly auto-backup on (PRD BAK-05).
/// Right(false) when the user cancelled.
class ChooseAutoBackupFolder {
  const ChooseAutoBackupFolder(this._repository, this._settings);

  final BackupRepository _repository;
  final BackupSettingsRepository _settings;

  Future<Either<Failure, bool>> call() async {
    final picked = await _repository.pickFolder();
    return picked.match((failure) async => Left(failure), (folder) async {
      if (folder == null) return const Right(false);
      final previous = (await _settings.getStatus())
          .toNullable()
          ?.autoBackupFolder;
      if (previous != null && previous.uri != folder.uri) {
        // Losing access to the old folder is harmless; don't fail on it.
        await _repository.releaseFolder(previous);
      }
      return (await _settings.setAutoBackupFolder(folder)).map((_) => true);
    });
  }
}

class TurnOffAutoBackup {
  const TurnOffAutoBackup(this._repository, this._settings);

  final BackupRepository _repository;
  final BackupSettingsRepository _settings;

  Future<Either<Failure, Unit>> call() async {
    final folder = (await _settings.getStatus()).toNullable()?.autoBackupFolder;
    if (folder != null) await _repository.releaseFolder(folder);
    return _settings.setAutoBackupFolder(null);
  }
}

enum AutoBackupOutcome { notDue, written, failed }

/// Writes a backup into the chosen folder when the last one is 7+ days old.
/// Runs on app open and resume; there is no background service (PRD
/// BAK-05). A failed write is recorded so the Backup page can say so.
class RunAutoBackup {
  const RunAutoBackup(
    this._repository,
    this._settings,
    this._encode,
    this._clock,
  );

  final BackupRepository _repository;
  final BackupSettingsRepository _settings;
  final EncodeBackup _encode;
  final Clock _clock;

  Future<Either<Failure, AutoBackupOutcome>> call({
    required String appVersion,
  }) async {
    final now = _clock.now();
    final status = await _settings.getStatus();
    return status.match((failure) async => Left(failure), (status) async {
      final folder = status.autoBackupFolder;
      if (folder == null || !status.autoBackupDue(now)) {
        return const Right(AutoBackupOutcome.notDue);
      }
      final written = await TaskEither(() => _encode(appVersion: appVersion))
          .flatMap(
            (contents) => TaskEither(
              () => _repository.writeToFolder(
                folder,
                ExportBackup.fileNameFor(LocalDate.fromDateTime(now)),
                contents,
              ),
            ),
          )
          .run();
      final succeeded = written.isRight();
      return (await _settings.recordAutoBackup(now, succeeded: succeeded)).map(
        (_) => succeeded ? AutoBackupOutcome.written : AutoBackupOutcome.failed,
      );
    });
  }
}
