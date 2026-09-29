import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/accounts_domain.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_file.freezed.dart';

/// Replace wipes the phone's data first; merge adds rows whose id is new
/// and keeps everything already there (PRD BAK-02).
enum RestoreMode { replace, merge }

/// What a backup file shows before restoring (PRD BAK-02).
@freezed
abstract class BackupPreview with _$BackupPreview {
  const factory BackupPreview({
    required int transactions,
    required int accounts,
    required int categories,
    LocalDate? firstDate,
    LocalDate? lastDate,
    required DateTime exportedAt,
  }) = _BackupPreview;
}

/// Every record on the phone, as exported (PRD BAK-01).
@Freezed(copyWith: false)
abstract class BackupFile with _$BackupFile {
  const factory BackupFile({
    required int schemaVersion,
    required String appVersion,
    required DateTime exportedAt,
    required List<Account> accounts,
    required List<Category> categories,
    required List<Transaction> transactions,

    /// Preferences and small app state, key → value.
    required Map<String, String> settings,
  }) = _BackupFile;

  const BackupFile._();

  /// The newest backup format this app reads and writes.
  static const currentSchemaVersion = 1;

  BackupPreview get preview {
    final dates = [for (final t in transactions) t.date]..sort();
    return BackupPreview(
      transactions: transactions.length,
      accounts: accounts.length,
      categories: categories.length,
      firstDate: dates.firstOrNull,
      lastDate: dates.lastOrNull,
      exportedAt: exportedAt,
    );
  }
}
