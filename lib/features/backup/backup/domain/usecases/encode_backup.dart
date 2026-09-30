import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Every record as backup-file text, encrypted when the user set a backup
/// password (PRD BAK-01, BAK-03).
class EncodeBackup {
  const EncodeBackup(this._repository, this._settings);

  final BackupRepository _repository;
  final BackupSettingsRepository _settings;

  Future<Either<Failure, String>> call({required String appVersion}) =>
      TaskEither(() => _repository.snapshot(appVersion: appVersion))
          .flatMap((file) => TaskEither.fromEither(_repository.encode(file)))
          .flatMap(
            (json) => TaskEither(_settings.readPassword).flatMap(
              (password) => password == null
                  ? TaskEither.right(json)
                  : TaskEither(() => _repository.encrypt(json, password)),
            ),
          )
          .run();
}
