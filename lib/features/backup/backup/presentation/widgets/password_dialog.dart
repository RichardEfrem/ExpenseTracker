import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/backup_preferences.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Asks for a new backup password, twice (PRD BAK-03). Returns it, or null
/// when cancelled.
Future<String?> showSetBackupPasswordDialog(BuildContext context) =>
    showDialog<String>(
      context: context,
      builder: (context) => const _PasswordDialog(confirm: true),
    );

/// Asks for the password of an encrypted backup. [wrong] shows that the
/// last try failed. Returns it, or null when cancelled.
Future<String?> showEnterBackupPasswordDialog(
  BuildContext context, {
  bool wrong = false,
}) => showDialog<String>(
  context: context,
  builder: (context) => _PasswordDialog(confirm: false, wrong: wrong),
);

class _PasswordDialog extends StatefulWidget {
  const _PasswordDialog({required this.confirm, this.wrong = false});

  /// Setting a new password: enter it twice, with a minimum length.
  final bool confirm;
  final bool wrong;

  @override
  State<_PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<_PasswordDialog> {
  final _password = TextEditingController();
  final _again = TextEditingController();
  var _obscure = true;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.wrong && _error == null && _password.text.isEmpty) {
      _error = AppLocalizations.of(context).failure_backup_password;
    }
  }

  /// On typing only: a controller listener would also fire when autofocus
  /// sets the selection, clearing the error before it's seen.
  void _clearError([String _ = '']) {
    if (_error != null) setState(() => _error = null);
  }

  @override
  void dispose() {
    _password.dispose();
    _again.dispose();
    super.dispose();
  }

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final password = _password.text;
    if (password.isEmpty) return;
    if (widget.confirm) {
      if (password.length < SetBackupPassword.minLength) {
        setState(() => _error = l10n.validation_password_short);
        return;
      }
      if (password != _again.text) {
        setState(() => _error = l10n.backup_password_mismatch);
        return;
      }
    }
    Navigator.pop(context, password);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final toggle = IconButton(
      tooltip: _obscure ? l10n.backup_password_show : l10n.backup_password_hide,
      icon: Icon(
        _obscure ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
      ),
      onPressed: () => setState(() => _obscure = !_obscure),
    );
    return AlertDialog(
      title: Text(
        widget.confirm
            ? l10n.backup_password_set_title
            : l10n.backup_password_enter_title,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.confirm
                  ? l10n.backup_password_set_body
                  : l10n.backup_password_enter_body,
            ),
            const SizedBox(height: Dimens.space4),
            TextField(
              key: const ValueKey('backup-password'),
              controller: _password,
              autofocus: true,
              obscureText: _obscure,
              enableSuggestions: false,
              autocorrect: false,
              textInputAction: widget.confirm
                  ? TextInputAction.next
                  : TextInputAction.done,
              onChanged: _clearError,
              onSubmitted: widget.confirm ? null : (_) => _submit(),
              decoration: InputDecoration(
                labelText: l10n.backup_password_label,
                suffixIcon: toggle,
                errorText: widget.confirm ? null : _error,
                errorMaxLines: 3,
              ),
            ),
            if (widget.confirm) ...[
              const SizedBox(height: Dimens.space3),
              TextField(
                key: const ValueKey('backup-password-again'),
                controller: _again,
                obscureText: _obscure,
                enableSuggestions: false,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                onChanged: _clearError,
                onSubmitted: (_) => _submit(),
                decoration: InputDecoration(
                  labelText: l10n.backup_password_again_label,
                  errorText: _error,
                  errorMaxLines: 3,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          key: const ValueKey('backup-password-ok'),
          onPressed: _submit,
          child: Text(
            widget.confirm ? l10n.common_save : l10n.backup_password_open,
          ),
        ),
      ],
    );
  }
}
