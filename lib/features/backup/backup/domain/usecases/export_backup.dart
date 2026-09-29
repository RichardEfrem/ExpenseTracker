import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Exports every record as one JSON file to the share sheet or a folder,
/// and records when (PRD BAK-01). Right(false) when the user cancelled.
class ExportBackup {
  const ExportBackup(this._repository, this._clock);

  final BackupRepository _repository;
  final Clock _clock;

  static String fileNameFor(LocalDate date) =>
      'expense-tracker-backup-${date.toIso()}.json';

  Future<Either<Failure, bool>> call({
    required String appVersion,
    required ExportTarget target,
  }) async {
    final now = _clock.now();
    final exported =
        await TaskEither(() => _repository.snapshot(appVersion: appVersion))
            .flatMap((file) => TaskEither.fromEither(_repository.encode(file)))
            .flatMap(
              (json) => TaskEither(
                () => _repository.deliver(
                  json,
                  fileNameFor(LocalDate.fromDateTime(now)),
                  target,
                ),
              ),
            )
            .run();
    return exported.match((failure) async => Left(failure), (delivered) async {
      if (!delivered) return const Right(false);
      return (await _repository.recordBackup(now)).map((_) => true);
    });
  }
}
