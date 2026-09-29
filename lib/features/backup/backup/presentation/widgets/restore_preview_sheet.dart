import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:flutter/material.dart';

/// "412 transactions · 5 accounts · Jan 2026 – Sep 2026", then Replace all
/// or Merge (DESIGN §8.10). Returns the chosen mode, or null.
Future<RestoreMode?> showRestorePreviewSheet(
  BuildContext context,
  BackupPreview preview,
) => showModalBottomSheet<RestoreMode>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  builder: (context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final first = preview.firstDate;
    final last = preview.lastDate;
    final range = first == null || last == null
        ? null
        : '${AppDateFormat.monthYear(first)} – ${AppDateFormat.monthYear(last)}';
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenPadding,
        0,
        Dimens.screenPadding,
        Dimens.screenPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.backup_restore_title, style: theme.textTheme.titleLarge),
          const SizedBox(height: Dimens.space3),
          Text(
            [
              l10n.backup_preview_transactions(preview.transactions),
              l10n.backup_preview_accounts(preview.accounts),
              l10n.backup_preview_categories(preview.categories),
              ?range,
            ].join(' · '),
            key: const ValueKey('restore-preview'),
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: Dimens.space1),
          Text(
            l10n.backup_preview_exported(
              AppDateFormat.dayMonthYear(
                LocalDate.fromDateTime(preview.exportedAt.toLocal()),
              ),
            ),
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: Dimens.space6),
          FilledButton(
            key: const ValueKey('restore-replace'),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.backup_replace_confirm_title),
                  content: Text(l10n.backup_replace_confirm_body),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(l10n.common_cancel),
                    ),
                    FilledButton(
                      key: const ValueKey('restore-replace-confirm'),
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(l10n.backup_replace_all),
                    ),
                  ],
                ),
              );
              if ((confirmed ?? false) && context.mounted) {
                Navigator.pop(context, RestoreMode.replace);
              }
            },
            child: Text(l10n.backup_replace_all),
          ),
          const SizedBox(height: Dimens.space2),
          OutlinedButton(
            key: const ValueKey('restore-merge'),
            onPressed: () => Navigator.pop(context, RestoreMode.merge),
            child: Text(l10n.backup_merge),
          ),
          const SizedBox(height: Dimens.space2),
          Text(
            l10n.backup_merge_hint,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  },
);
