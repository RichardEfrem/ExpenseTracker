import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_status.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/picked_backup.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/backup/presentation/providers/backup_actions.dart';
import 'package:expense_tracker/features/backup/backup/presentation/providers/backup_status_notifiers.dart';
import 'package:expense_tracker/features/backup/backup/presentation/widgets/password_dialog.dart';
import 'package:expense_tracker/features/backup/backup/presentation/widgets/restore_preview_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Backup & data (DESIGN §8.10): export, restore, encryption, weekly
/// auto-backup, the reminder, CSV export and erase.
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
    final backup = picked.match((failure) {
      _toast(failureMessage(l10n, failure));
      return null;
    }, (backup) => backup);
    final file = switch (backup) {
      null => null,
      ReadableBackup(:final file) => file,
      final LockedBackup locked => await _unlock(locked),
    };
    if (file == null || !mounted) return;
    final mode = await showRestorePreviewSheet(context, file.preview);
    if (mode == null || !mounted) return;
    await _run(() async {
      final failure = await _actions.restore(file, mode);
      _toast(
        failure == null ? l10n.backup_restored : failureMessage(l10n, failure),
      );
    });
  }

  /// Asks for the password until it opens the file or the user cancels.
  Future<BackupFile?> _unlock(LockedBackup backup) async {
    final l10n = AppLocalizations.of(context);
    var wrong = false;
    while (true) {
      if (!mounted) return null;
      final password = await showEnterBackupPasswordDialog(
        context,
        wrong: wrong,
      );
      if (password == null || !mounted) return null;
      BackupFile? file;
      await _run(() async {
        final opened = await _actions.unlock(backup, password);
        opened.match((failure) {
          wrong =
              failure is BackupFailure &&
              failure.problem == BackupProblem.wrongPassword;
          if (!wrong) _toast(failureMessage(l10n, failure));
        }, (opened) => file = opened);
      });
      if (file != null || !wrong) return file;
    }
  }

  Future<void> _setEncryption(bool on) async {
    final l10n = AppLocalizations.of(context);
    final password = on ? await showSetBackupPasswordDialog(context) : null;
    if (on && password == null) return;
    if (!mounted) return;
    final failure = await ref
        .read(backupEncryptionProvider.notifier)
        .setPassword(password);
    _toast(
      failure != null
          ? failureMessage(l10n, failure)
          : on
          ? l10n.backup_encrypt_on
          : l10n.backup_encrypt_off,
    );
  }

  Future<void> _setAutoBackup(bool on) async {
    final l10n = AppLocalizations.of(context);
    if (!on) {
      final failure = await _actions.turnOffAutoBackup();
      if (failure != null) _toast(failureMessage(l10n, failure));
      return;
    }
    await _run(() async {
      final chosen = await _actions.chooseAutoBackupFolder();
      chosen.match((failure) => _toast(failureMessage(l10n, failure)), (
        chosen,
      ) {
        if (chosen) _toast(l10n.backup_auto_on);
      });
    });
  }

  Future<void> _setReminder(bool on) async {
    final failure = await _actions.setReminder(enabled: on);
    if (failure != null && mounted) {
      _toast(failureMessage(AppLocalizations.of(context), failure));
    }
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
    final status =
        ref.watch(backupStatusProvider).value ?? const BackupStatus();
    final encrypted = ref.watch(backupEncryptionProvider).value ?? false;
    final lastBackup = status.lastBackupAt;
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
            const SizedBox(height: Dimens.space4),
            SwitchListTile(
              key: const ValueKey('encrypt'),
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Symbols.encrypted_rounded),
              title: Text(l10n.backup_encrypt),
              subtitle: Text(
                encrypted
                    ? l10n.backup_encrypt_hint_on
                    : l10n.backup_encrypt_hint,
              ),
              value: encrypted,
              onChanged: _setEncryption,
            ),
            SwitchListTile(
              key: const ValueKey('auto-backup'),
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Symbols.folder_rounded),
              title: Text(l10n.backup_auto),
              subtitle: Text(_autoBackupLabel(l10n, status)),
              value: status.autoBackupFolder != null,
              onChanged: _setAutoBackup,
            ),
            if (status.autoBackupFolder != null)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  key: const ValueKey('auto-backup-folder'),
                  onPressed: () => _setAutoBackup(true),
                  child: Text(l10n.backup_auto_change_folder),
                ),
              ),
            SwitchListTile(
              key: const ValueKey('reminder'),
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Symbols.notifications_rounded),
              title: Text(l10n.backup_reminder_setting),
              value: status.reminderEnabled,
              onChanged: _setReminder,
            ),
            const Divider(),
            ListTile(
              key: const ValueKey('export-csv'),
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Symbols.table_view_rounded),
              title: Text(l10n.more_export_csv),
              subtitle: Text(l10n.csv_subtitle),
              trailing: const Icon(Symbols.chevron_right_rounded),
              onTap: () => context.push(AppPaths.csvExport),
            ),
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

  String _autoBackupLabel(AppLocalizations l10n, BackupStatus status) {
    final folder = status.autoBackupFolder;
    if (folder == null) return l10n.backup_auto_hint;
    if (status.autoBackupFailed) return l10n.backup_auto_failed(folder.name);
    final last = status.lastAutoBackupAt;
    if (last == null) return l10n.backup_auto_folder(folder.name);
    return l10n.backup_auto_last(
      folder.name,
      AppDateFormat.dayMonth(LocalDate.fromDateTime(last.toLocal())),
    );
  }
}
