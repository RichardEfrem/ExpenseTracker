import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Full-screen error with retry, for app-wide failures (CLAUDE §3).
class AppErrorPage extends StatelessWidget {
  const AppErrorPage({required this.failure, this.onRetry, super.key});

  final Failure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.error_title)),
      body: Center(
        child: SingleChildScrollView(
          child: EmptyState(
            icon: Symbols.error_rounded,
            message: failureMessage(l10n, failure),
            actionLabel: l10n.common_retry,
            onAction: onRetry,
          ),
        ),
      ),
    );
  }
}
