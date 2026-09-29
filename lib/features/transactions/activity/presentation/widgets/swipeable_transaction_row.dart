import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_detail_sheet.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_feedback.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Swipe left = delete with Undo, swipe right = duplicate (DESIGN §7.3).
/// Both also live in the detail sheet, since swipes aren't discoverable.
class SwipeableTransactionRow extends StatelessWidget {
  const SwipeableTransactionRow({
    required this.view,
    required this.showAccount,
    required this.onDeleted,
    super.key,
  });

  final TransactionView view;
  final bool showAccount;

  /// Called when the row is swiped away, so the list can hide it until the
  /// database confirms.
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final id = view.transaction.id;

    Widget background(
      Color color,
      Color onColor,
      IconData icon,
      String label,
      Alignment alignment,
    ) => ColoredBox(
      color: color,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space6),
          child: Icon(icon, color: onColor, semanticLabel: label),
        ),
      ),
    );

    return Dismissible(
      key: ValueKey('dismiss-$id'),
      background: background(
        theme.colorScheme.primary,
        theme.colorScheme.onPrimary,
        Symbols.content_copy_rounded,
        l10n.transaction_duplicate,
        Alignment.centerLeft,
      ),
      secondaryBackground: background(
        FinanceColors.of(context).expense,
        theme.colorScheme.onError,
        Symbols.delete_rounded,
        l10n.common_delete,
        Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await duplicateTransaction(context, id);
          return false;
        }
        return true;
      },
      onDismissed: (_) {
        onDeleted();
        deleteTransactionWithUndo(context, id);
      },
      child: Semantics(
        customSemanticsActions: {
          CustomSemanticsAction(label: l10n.transaction_duplicate): () =>
              duplicateTransaction(context, id),
          CustomSemanticsAction(label: l10n.common_delete): () =>
              deleteTransactionWithUndo(context, id),
        },
        child: TransactionRow(
          view,
          showAccount: showAccount,
          onTap: () => showTransactionDetailSheet(context, id),
        ),
      ),
    );
  }
}
