import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/widgets/adaptive_layout.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/presentation/widgets/recurring_labels.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';

/// A due occurrence waiting for the user (DESIGN §8.9), warning-tinted:
/// "Rent · Rp 3.000.000 · Due 25 Sep · SKIP · CONFIRM".
class PendingItemCard extends StatelessWidget {
  const PendingItemCard({
    required this.item,
    required this.onConfirm,
    required this.onSkip,
    super.key,
  });

  final PendingView item;
  final VoidCallback onConfirm;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final finance = FinanceColors.of(context);
    final rule = item.rule.rule;
    final buttonStyle = TextButton.styleFrom(foregroundColor: finance.warning);
    final amount = MoneyText(rule.amount, kind: amountKindOf(rule.type));
    final stacked = useStackedLayout(context);
    return Card(
      color: finance.warningContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.cardPadding,
          Dimens.cardPadding,
          Dimens.space2,
          Dimens.space2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RuleIcon(item.rule),
                const SizedBox(width: Dimens.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ruleTitle(l10n, item.rule),
                        style: theme.textTheme.bodyLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (stacked) amount,
                      Text(
                        l10n.recurring_due(
                          AppDateFormat.dayMonth(item.pending.date),
                        ),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: finance.warning,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!stacked) ...[const SizedBox(width: Dimens.space2), amount],
              ],
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: buttonStyle,
                  onPressed: onSkip,
                  child: Text(l10n.recurring_skip),
                ),
                TextButton(
                  style: buttonStyle,
                  onPressed: onConfirm,
                  child: Text(l10n.recurring_confirm),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
