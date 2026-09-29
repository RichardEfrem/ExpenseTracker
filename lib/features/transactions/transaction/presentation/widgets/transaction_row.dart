import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/widgets/adaptive_layout.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_labels.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// One transaction in a list (DESIGN §7.3): category icon, category name
/// over note · account, amount over time.
class TransactionRow extends StatelessWidget {
  const TransactionRow(
    this.view, {
    this.showAccount = false,
    this.onTap,
    super.key,
  });

  final TransactionView view;

  /// Only when the user has more than one account.
  final bool showAccount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final t = view.transaction;
    final secondary = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final account = t.type == TransactionType.transfer && view.toAccount != null
        ? '${view.account.name} → ${view.toAccount!.name}'
        : view.account.name;
    final subtitle = [
      if (t.note != null) t.note!,
      if (showAccount || t.type == TransactionType.transfer) account,
    ].join(' · ');

    final title = Text(
      transactionTitle(l10n, view),
      style: theme.textTheme.bodyLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
    final details = subtitle.isNotEmpty || t.recurringRuleId != null
        ? Row(
            children: [
              Flexible(
                child: Text(
                  subtitle,
                  style: secondary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (t.recurringRuleId != null) ...[
                const SizedBox(width: Dimens.space1),
                Icon(
                  Symbols.repeat_rounded,
                  size: 14,
                  color: secondary.color,
                  semanticLabel: l10n.transaction_recurring,
                ),
              ],
            ],
          )
        : null;
    final amount = MoneyText(t.signedAmount, kind: amountKindOf(t.type));
    final time = Text(
      t.time.format(),
      style: theme.textTheme.labelSmall!.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
    final stacked = useStackedLayout(context);

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimens.rowHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.screenPadding,
            vertical: Dimens.space2,
          ),
          child: Row(
            children: [
              if (view.category case final category?)
                CategoryIcon(category)
              else
                IconCircle(
                  icon: t.type == TransactionType.transfer
                      ? Symbols.swap_horiz_rounded
                      : Symbols.tune_rounded,
                  color: FinanceColors.of(context).transfer,
                  semanticLabel: transactionTypeLabel(l10n, t.type),
                ),
              const SizedBox(width: Dimens.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    ?details,
                    if (stacked)
                      Wrap(
                        spacing: Dimens.space2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [amount, time],
                      ),
                  ],
                ),
              ),
              if (!stacked) ...[
                const SizedBox(width: Dimens.space2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [amount, time],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
