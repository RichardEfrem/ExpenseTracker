import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/accounts_domain.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/recurring/recurring_domain.dart';
import 'package:expense_tracker/features/tags/tags_domain.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_file.freezed.dart';

/// Replace wipes the phone's data first; merge adds rows whose id is new
/// and keeps everything already there (PRD BAK-02).
enum RestoreMode { replace, merge }

/// A transaction carrying a tag.
@freezed
abstract class TagLink with _$TagLink {
  const factory TagLink({
    required String transactionId,
    required String tagId,
  }) = _TagLink;
}

/// What a backup file shows before restoring (PRD BAK-02).
@freezed
abstract class BackupPreview with _$BackupPreview {
  const factory BackupPreview({
    required int transactions,
    required int accounts,
    required int categories,
    @Default(0) int recurringRules,
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

    /// Schema v2 on; empty when restoring a v1 file.
    @Default([]) List<RecurringRule> recurringRules,
    @Default([]) List<PendingOccurrence> pendingOccurrences,

    /// Schema v3 on; empty when restoring a v1 or v2 file.
    @Default([]) List<Tag> tags,
    @Default([]) List<TagLink> tagLinks,

    /// Preferences and small app state, key → value.
    required Map<String, String> settings,
  }) = _BackupFile;

  const BackupFile._();

  /// The newest backup format this app reads and writes. v2 adds recurring
  /// rules and pending occurrences, v3 tags; v1 and v2 files still restore.
  static const currentSchemaVersion = 3;

  BackupPreview get preview {
    final dates = [for (final t in transactions) t.date]..sort();
    return BackupPreview(
      transactions: transactions.length,
      accounts: accounts.length,
      categories: categories.length,
      recurringRules: recurringRules.length,
      firstDate: dates.firstOrNull,
      lastDate: dates.lastOrNull,
      exportedAt: exportedAt,
    );
  }
}
