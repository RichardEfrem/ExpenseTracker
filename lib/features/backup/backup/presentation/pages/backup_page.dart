import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/presentation/providers/backup_actions.dart';
import 'package:expense_tracker/features/backup/backup/presentation/widgets/restore_preview_sheet.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Backup & data (DESIGN §8.10, MVP subset): export, restore, erase.
class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  var _busy = false;

  BackupActions get _actions => ref.read(backupActionsProvider.notifier);

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _export(ExportTarget target) => _run(() async {
    final l10n = AppLocalizations.of(context);
    final result = await _actions.export(target);
    result.match((failure) => _toast(failureMessage(l10n, failure)), (
      delivered,
    ) {
      if (delivered) _toast(l10n.backup_exported);
    });
  });

  Future<void> _restore() async {
    final l10n = AppLocalizations.of(context);
    final picked = await _actions.pick();
    if (!mounted) return;
    final file = picked.match((failure) {
      _toast(failureMessage(l10n, failure));
      return null;
    }, (file) => file);
    if (file == null) return;
    final mode = await showRestorePreviewSheet(context, file.preview);
    if (mode == null || !mounted) return;
    await _run(() async {
      final failure = await _actions.restore(file, mode);
      _toast(
        failure == null ? l10n.backup_restored : failureMessage(l10n, failure),
      );
    });
  }

  Future<void> _erase() async {
    final l10n = AppLocalizations.of(context);
    Future<bool> confirm(
      String title,
      String body,
      String action,
      Key key,
    ) async =>
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.common_cancel),
              ),
              FilledButton(
                key: key,
                style: FilledButton.styleFrom(
                  backgroundColor: FinanceColors.of(context).expense,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: Text(action),
              ),
            ],
          ),
        ) ??
        false;

    // Double confirmation (PRD §4.6).
    if (!await confirm(
      l10n.backup_erase_title,
      l10n.backup_erase_body,
      l10n.backup_erase_continue,
      const ValueKey('erase-1'),
    )) {
      return;
    }
    if (!mounted) return;
    if (!await confirm(
      l10n.backup_erase_again_title,
      l10n.backup_erase_again_body,
      l10n.backup_erase_confirm,
      const ValueKey('erase-2'),
    )) {
      return;
    }
    await _run(() async {
      final failure = await _actions.eraseAll();
      _toast(
        failure == null ? l10n.backup_erased : failureMessage(l10n, failure),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    // Keeps the actions alive across their async work.
    ref.watch(backupActionsProvider);
    final lastBackup = ref.watch(settingsProvider).value?.lastBackupAt;
    final today = LocalDate.today(ref.watch(clockProvider));

    String lastBackupLabel() {
      if (lastBackup == null) return l10n.backup_never;
      final local = lastBackup.toLocal();
      final days = LocalDate.fromDateTime(local).daysUntil(today);
      return l10n.backup_last(
        l10n.backup_days_ago(days),
        '${AppDateFormat.dayMonth(LocalDate.fromDateTime(local))}, '
        '${AppDateFormat.time(local)}',
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.more_backup)),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          padding: const EdgeInsets.all(Dimens.screenPadding),
          children: [
            if (_busy) const LinearProgressIndicator(),
            Text(
              lastBackupLabel(),
              key: const ValueKey('last-backup'),
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: Dimens.space4),
            FilledButton.icon(
              key: const ValueKey('export'),
              icon: const Icon(Symbols.ios_share_rounded),
              label: Text(l10n.backup_export),
              onPressed: () => _export(ExportTarget.share),
            ),
            const SizedBox(height: Dimens.space2),
            OutlinedButton.icon(
              key: const ValueKey('save'),
              icon: const Icon(Symbols.save_rounded),
              label: Text(l10n.backup_save_to_device),
              onPressed: () => _export(ExportTarget.saveToDevice),
            ),
            const SizedBox(height: Dimens.space2),
            OutlinedButton.icon(
              key: const ValueKey('restore'),
              icon: const Icon(Symbols.restore_rounded),
              label: Text(l10n.backup_restore),
              onPressed: _restore,
            ),
            const SizedBox(height: Dimens.space2),
            Text(
              l10n.backup_hint,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Dimens.space8),
            const Divider(),
            ListTile(
              key: const ValueKey('erase'),
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Symbols.delete_forever_rounded,
                color: FinanceColors.of(context).expense,
              ),
              title: Text(
                l10n.more_erase_all,
                style: TextStyle(color: FinanceColors.of(context).expense),
              ),
              subtitle: Text(l10n.backup_erase_subtitle),
              onTap: _erase,
            ),
          ],
        ),
      ),
    );
  }
}
