import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/period/period_presentation.dart';
import 'package:expense_tracker/features/reports/reports_presentation.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// The dashboard (DESIGN §8.1): net hero, income and expense, top spending,
/// recent transactions. Reading order matches visual order.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const _recentCount = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final hour = ref.watch(clockProvider).now().hour;
    final scope = ref.watch(reportScopeProvider);
    final stats = ref.watch(statisticsProvider(scope)).value;
    final top = ref
        .watch(categoryBreakdownProvider(scope, CategoryType.expense))
        .value;
    final recent = ref.watch(recentTransactionsProvider(_recentCount));
    final multipleAccounts =
        (ref.watch(accountsProvider()).value?.length ?? 0) > 1;
    final period = scope.period;

    final greeting = hour < 12
        ? l10n.home_good_morning
        : hour < 18
        ? l10n.home_good_afternoon
        : l10n.home_good_evening;

    final noData = recent.value?.isEmpty ?? false;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.screenPadding,
                  Dimens.space4,
                  Dimens.space2,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          greeting,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.nav_more,
                      icon: const Icon(Symbols.settings_rounded),
                      onPressed: () => context.go(AppPaths.more),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.space2),
                child: PeriodSelector(),
              ),
            ),
            if (noData)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: EmptyState(
                    icon: Symbols.receipt_long_rounded,
                    message: l10n.home_empty,
                    actionLabel: l10n.fab_add_expense,
                    onAction: () => context.push(AppPaths.addOfType('expense')),
                  ),
                ),
              )
            else ...[
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.screenPadding,
                ),
                sliver: SliverList.list(
                  children: [
                    _NetCard(
                      period: period,
                      stats: stats,
                      balance: multipleAccounts
                          ? ref
                                .watch(accountBalancesProvider)
                                .value
                                ?.where((b) => !b.account.isArchived)
                                .fold<int>(0, (sum, b) => sum + b.balance)
                          : null,
                    ),
                    const SizedBox(height: Dimens.cardGap),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _SummaryCard(
                              key: const ValueKey('income-card'),
                              icon: Symbols.arrow_downward_rounded,
                              color: FinanceColors.of(context).income,
                              label: l10n.type_income,
                              amount: stats?.income ?? 0,
                              previous: stats?.previousIncome ?? 0,
                              onTap: () => drillDown(
                                context,
                                periodFilter(
                                  period,
                                  types: {TransactionType.income},
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Dimens.cardGap),
                          Expanded(
                            child: _SummaryCard(
                              key: const ValueKey('expense-card'),
                              icon: Symbols.arrow_upward_rounded,
                              color: FinanceColors.of(context).expense,
                              label: l10n.type_expense,
                              amount: stats?.expense ?? 0,
                              previous: stats?.previousExpense ?? 0,
                              onTap: () => drillDown(
                                context,
                                periodFilter(
                                  period,
                                  types: {TransactionType.expense},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.cardGap),
                    if (top != null && top.totals.isNotEmpty)
                      _TopSpending(period: period, breakdown: top),
                    const SizedBox(height: Dimens.space4),
                    Row(
                      children: [
                        Expanded(
                          child: Semantics(
                            header: true,
                            child: Text(
                              l10n.home_recent,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(AppPaths.activity),
                          child: Text(l10n.home_see_all),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverList.list(
                children: [
                  for (final view in recent.value ?? const <TransactionView>[])
                    TransactionRow(
                      view,
                      showAccount: multipleAccounts,
                      onTap: () => showTransactionDetailSheet(
                        context,
                        view.transaction.id,
                      ),
                    ),
                ],
              ),
              // Room for the FAB over the last row.
              const SliverToBoxAdapter(child: SizedBox(height: 112)),
            ],
          ],
        ),
      ),
    );
  }
}

/// `▲ 12,4% vs Aug`; the arrow and "vs" carry direction, color stays
/// neutral (DESIGN §7.2).
String? changeLabel(
  AppLocalizations l10n,
  int current,
  int previous,
  Period period,
) {
  final change = MoneyFormat.change(current, previous);
  if (change == null) return null;
  final prev = period.previous();
  final label = prev.isCalendarMonth
      ? AppDateFormat.monthShort(prev.start)
      : l10n.home_previous_period;
  return l10n.home_vs(change, label);
}

class _NetCard extends StatelessWidget {
  const _NetCard({
    required this.period,
    required this.stats,
    required this.balance,
  });

  final Period period;
  final PeriodStatistics? stats;

  /// Total across accounts; shown only with more than one account.
  final int? balance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final stats = this.stats;
    final change = stats == null
        ? null
        : changeLabel(l10n, stats.net, stats.previousNet, period);
    return Card(
      key: const ValueKey('net-card'),
      child: InkWell(
        onTap: () => context.go(AppPaths.reports),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.home_net(AppDateFormat.period(period)),
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: Dimens.space1),
              MoneyText(
                stats?.net ?? 0,
                kind: AmountKind.net,
                hero: true,
                countUp: true,
              ),
              if (change != null)
                Text(
                  change,
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              if (balance case final balance?) ...[
                const SizedBox(height: Dimens.space2),
                Wrap(
                  key: const ValueKey('home-balance'),
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: Dimens.space2,
                  children: [
                    Text(
                      l10n.home_balance_all,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    MoneyText(balance, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends ConsumerWidget {
  const _SummaryCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.amount,
    required this.previous,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String label;
  final int amount;
  final int previous;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final period = ref.watch(reportScopeProvider).period;
    final change = changeLabel(l10n, amount, previous, period);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: color),
                  const SizedBox(width: Dimens.space1),
                  Flexible(
                    child: Text(label, style: theme.textTheme.labelLarge),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.space1),
              MoneyText(
                amount,
                hero: true,
                countUp: true,
                style: theme.textTheme.headlineSmall,
              ),
              if (change != null)
                Text(
                  change,
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Top 3 expense categories as horizontal bars in category color (DESIGN
/// §8.1: easier to compare 3 values than a donut in a narrow card).
class _TopSpending extends StatelessWidget {
  const _TopSpending({required this.period, required this.breakdown});

  final Period period;
  final CategoryBreakdown breakdown;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final finance = FinanceColors.of(context);
    final top = breakdown.totals.take(3).toList();
    final max = top.first.amount;
    return Card(
      key: const ValueKey('top-spending'),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.home_top_spending, style: theme.textTheme.titleMedium),
            const SizedBox(height: Dimens.space2),
            for (final total in top)
              InkWell(
                borderRadius: BorderRadius.circular(Dimens.radiusSmall),
                onTap: () => drillDown(
                  context,
                  periodFilter(period, categoryIds: {total.category.id}),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
                  child: Row(
                    children: [
                      CategoryIcon(total.category, size: 28),
                      const SizedBox(width: Dimens.space2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              total.category.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: Dimens.space1),
                            FractionallySizedBox(
                              widthFactor: max == 0 ? 0 : total.amount / max,
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: finance.category(total.category.color),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimens.space3),
                      MoneyText(total.amount, kind: AmountKind.expense),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
