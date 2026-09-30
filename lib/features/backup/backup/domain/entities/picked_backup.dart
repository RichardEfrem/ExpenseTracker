import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';

/// A backup file the user picked to restore.
sealed class PickedBackup {
  const PickedBackup();
}

/// A plain backup, already read.
final class ReadableBackup extends PickedBackup {
  const ReadableBackup(this.file);

  final BackupFile file;
}

/// An encrypted backup (PRD BAK-03): needs its password before it can be
/// read.
final class LockedBackup extends PickedBackup {
  const LockedBackup(this.contents);

  /// The file's text, as picked.
  final String contents;
}
