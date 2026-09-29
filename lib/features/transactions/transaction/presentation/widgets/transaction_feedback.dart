import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/motion.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/transaction_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Deletes the transaction and offers Undo for 5 s instead of a confirm
/// dialog (PRD TX-07). Safe to call from a sheet that closes right after.
Future<void> deleteTransactionWithUndo(BuildContext context, String id) async {
  final container = ProviderScope.containerOf(context, listen: false);
  final messenger = ScaffoldMessenger.of(context);
  final l10n = AppLocalizations.of(context);
  final result = await container
      .read(transactionActionsProvider.notifier)
      .delete(id);
  messenger.hideCurrentSnackBar();
  result.match(
    (failure) => messenger.showSnackBar(
      SnackBar(content: Text(failureMessage(l10n, failure))),
    ),
    (deleted) => messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.transaction_deleted),
        duration: Motion.undoWindow,
        persist: false,
        action: SnackBarAction(
          label: l10n.common_undo,
          onPressed: () async {
            final failure = await container
                .read(transactionActionsProvider.notifier)
                .restore(deleted);
            if (failure != null) {
              messenger.showSnackBar(
                SnackBar(content: Text(failureMessage(l10n, failure))),
              );
            }
          },
        ),
      ),
    ),
  );
}

/// "Add again" (PRD TX-08) with a confirmation snackbar.
Future<void> duplicateTransaction(BuildContext context, String id) async {
  final container = ProviderScope.containerOf(context, listen: false);
  final messenger = ScaffoldMessenger.of(context);
  final l10n = AppLocalizations.of(context);
  final result = await container
      .read(transactionActionsProvider.notifier)
      .duplicate(id);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          result.match(
            (failure) => failureMessage(l10n, failure),
            (_) => l10n.transaction_duplicated,
          ),
        ),
      ),
    );
}
