import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/reports/statistics/domain/entities/period_statistics.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';

/// A statistic card: its label, value and definition (PRD §5.3).
typedef StatCard = ({
  String key,
  String label,
  String value,
  String spoken,
  String definition,
  String? transactionId,
});

/// The cards that apply to [stats]; ones without a meaningful value (e.g.
/// savings rate without income) are left out.
List<StatCard> statCardsFor(AppLocalizations l10n, PeriodStatistics stats) {
  StatCard money(
    String key,
    String label,
    int amount,
    String definition, {
    String? id,
  }) => (
    key: key,
    label: label,
    value: MoneyFormat.compact(amount),
    spoken: moneySemantics(l10n, amount),
    definition: definition,
    transactionId: id,
  );
  final savings = stats.savingsRate;
  final average = stats.averageDailySpend;
  final projected = stats.projectedMonthEnd;
  final noSpend = stats.noSpendDays;
  final largest = stats.largestExpense;
  final frequent = stats.mostFrequentCategory;
  return [
    if (savings != null)
      (
        key: 'savings',
        label: l10n.stat_savings_rate,
        value: MoneyFormat.percent(savings),
        spoken: MoneyFormat.percent(savings),
        definition: l10n.stat_savings_rate_definition,
        transactionId: null,
      ),
    if (average != null)
      money(
        'average',
        l10n.stat_average_daily,
        average,
        l10n.stat_average_daily_definition,
      ),
    if (projected != null)
      money(
        'projected',
        l10n.stat_projected,
        projected,
        l10n.stat_projected_definition,
      ),
    if (noSpend != null)
      (
        key: 'no-spend',
        label: l10n.stat_no_spend_days,
        value: l10n.stat_days(noSpend),
        spoken: l10n.stat_days(noSpend),
        definition: l10n.stat_no_spend_days_definition,
        transactionId: null,
      ),
    if (largest != null)
      money(
        'largest',
        l10n.stat_largest_expense,
        largest.amount,
        l10n.stat_largest_expense_definition(
          largest.category?.name ?? '',
          AppDateFormat.dayMonth(largest.date),
        ),
        id: largest.transactionId,
      ),
    if (frequent != null)
      (
        key: 'frequent',
        label: l10n.stat_most_frequent,
        value: frequent.category.name,
        spoken: frequent.category.name,
        definition: l10n.stat_most_frequent_definition(frequent.count),
        transactionId: null,
      ),
  ];
}

/// Horizontally scrolling stat cards (DESIGN §8.5); tap for the definition.
class StatCardsRow extends StatelessWidget {
  const StatCardsRow({required this.stats, super.key});

  final PeriodStatistics stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cards = statCardsFor(l10n, stats);
    final scale = MediaQuery.textScalerOf(context).scale(1);
    return SizedBox(
      height: Dimens.statCardHeight * (scale > 1 ? scale * 0.85 : 1),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
        itemCount: cards.length,
        separatorBuilder: (_, _) => const SizedBox(width: Dimens.space2),
        itemBuilder: (context, i) {
          final card = cards[i];
          return SizedBox(
            width: Dimens.statCardWidth * (scale > 1 ? scale * 0.85 : 1),
            child: Card(
              child: InkWell(
                key: ValueKey('stat-${card.key}'),
                onTap: () => _showDefinition(context, card),
                child: Semantics(
                  button: true,
                  label: '${card.label}, ${card.spoken}',
                  excludeSemantics: true,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.space3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelMedium!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            card.value,
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Future<void> _showDefinition(BuildContext context, StatCard card) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.screenPadding,
          0,
          Dimens.screenPadding,
          Dimens.space6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(card.label, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Dimens.space2),
            Text(card.value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: Dimens.space4),
            Text(card.definition, style: Theme.of(context).textTheme.bodyLarge),
            if (card.transactionId case final id?) ...[
              const SizedBox(height: Dimens.space4),
              FilledButton.tonal(
                onPressed: () {
                  Navigator.pop(sheetContext);
                  showTransactionDetailSheet(context, id);
                },
                child: Text(l10n.stat_open_transaction),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
