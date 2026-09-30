import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/backup/backup/presentation/providers/backup_actions.dart';
import 'package:expense_tracker/features/backup/backup/presentation/providers/backup_status_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// "Last backup 34 days ago · BACK UP NOW · LATER" on Home (DESIGN §7.11,
/// PRD BAK-04); takes no space when no reminder is due.
class BackupReminderBanner extends ConsumerWidget {
  const BackupReminderBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider).now();
    final due = ref.watch(
      backupStatusProvider.select((s) => s.value?.reminderDue(now)),
    );
    if (due == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final finance = FinanceColors.of(context);
    final days = due.daysSinceBackup;
    final actionStyle = TextButton.styleFrom(foregroundColor: finance.warning);
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.cardGap),
      child: Card(
        key: const ValueKey('backup-reminder'),
        color: finance.warningContainer,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.cardPadding,
            Dimens.space3,
            Dimens.space2,
            Dimens.space1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Symbols.warning_rounded, color: finance.warning),
                  const SizedBox(width: Dimens.space3),
                  Expanded(
                    child: Text(
                      days == null
                          ? l10n.backup_reminder_never
                          : l10n.backup_reminder_days(days),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    key: const ValueKey('backup-reminder-later'),
                    style: actionStyle,
                    onPressed: () => ref
                        .read(backupActionsProvider.notifier)
                        .snoozeReminder(),
                    child: Text(l10n.backup_reminder_later),
                  ),
                  TextButton(
                    key: const ValueKey('backup-reminder-now'),
                    style: actionStyle,
                    onPressed: () => context.push(AppPaths.backup),
                    child: Text(l10n.backup_reminder_now),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
