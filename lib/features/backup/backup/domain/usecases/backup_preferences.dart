import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchBackupStatus {
  const WatchBackupStatus(this._settings);

  final BackupSettingsRepository _settings;

  Stream<Either<Failure, BackupStatus>> call() => _settings.watchStatus();
}

/// Turns the 30-day backup reminder on or off (PRD BAK-04).
class SetBackupReminder {
  const SetBackupReminder(this._settings);

  final BackupSettingsRepository _settings;

  Future<Either<Failure, Unit>> call({required bool enabled}) =>
      _settings.setReminderEnabled(enabled);
}

/// "Later" on the reminder: hides it for [BackupStatus.snooze].
class SnoozeBackupReminder {
  const SnoozeBackupReminder(this._settings, this._clock);

  final BackupSettingsRepository _settings;
  final Clock _clock;

  Future<Either<Failure, Unit>> call() =>
      _settings.snoozeReminderUntil(_clock.now().add(BackupStatus.snooze));
}

/// Whether new backups are encrypted (a backup password is set).
class GetBackupEncryption {
  const GetBackupEncryption(this._settings);

  final BackupSettingsRepository _settings;

  Future<Either<Failure, bool>> call() async =>
      (await _settings.readPassword()).map((password) => password != null);
}

/// Sets the password new backups are encrypted with, or turns encryption
/// off with null (PRD BAK-03).
class SetBackupPassword {
  const SetBackupPassword(this._settings);

  final BackupSettingsRepository _settings;

  static const minLength = 8;

  Future<Either<Failure, Unit>> call(String? password) async {
    if (password != null && password.length < minLength) {
      return const Left(Failure.validation(ValidationReason.passwordTooShort));
    }
    return _settings.setPassword(password);
  }
}
