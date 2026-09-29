import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/core/widgets/multi_select_sheet.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/period/period_presentation.dart';
import 'package:expense_tracker/features/reports/calendar/presentation/widgets/calendar_view.dart';
import 'package:expense_tracker/features/reports/category_breakdown/presentation/widgets/category_breakdown_view.dart';
import 'package:expense_tracker/features/reports/category_trend/presentation/widgets/category_trend_view.dart';
import 'package:expense_tracker/features/reports/compare/presentation/widgets/compare_view.dart';
import 'package:expense_tracker/features/reports/daily/presentation/widgets/daily_view.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/shared/presentation/providers/report_scope_notifier.dart';
import 'package:expense_tracker/features/reports/statistics/presentation/providers/statistics_notifier.dart';
import 'package:expense_tracker/features/reports/statistics/presentation/widgets/stat_cards.dart';
import 'package:expense_tracker/features/reports/trends/presentation/widgets/trends_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Reports and statistics (DESIGN §8.5): period, stat cards, and one tab
/// per report: Categories, Trends, Daily, Compare, Calendar.
class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scope = ref.watch(reportScopeProvider);
    final stats = ref.watch(statisticsProvider(scope)).value;
    final tabs = [
      (
        l10n.reports_tab_categories,
        (ReportScope s) => CategoryBreakdownView(scope: s),
      ),
      (l10n.reports_tab_trends, (ReportScope s) => _TrendsTab(scope: s)),
      (l10n.reports_tab_daily, (ReportScope s) => DailyView(scope: s)),
      (l10n.reports_tab_compare, (ReportScope s) => CompareView(scope: s)),
      (l10n.reports_tab_calendar, (ReportScope s) => CalendarView(scope: s)),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              title: Text(l10n.nav_reports),
              floating: true,
              actions: [_AccountScopeButton(scope: scope)],
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.space2),
                child: PeriodSelector(),
              ),
            ),
            if (stats != null && !stats.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.space2),
                  child: StatCardsRow(stats: stats),
                ),
              ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarHeader(
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [for (final (label, _) in tabs) Tab(text: label)],
                ),
                Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
          body: stats == null
              ? const Center(child: CircularProgressIndicator())
              : stats.isEmpty
              ? _EmptyPeriod(scope: scope)
              : TabBarView(
                  children: [
                    for (final (_, build) in tabs)
                      ListView(
                        padding: const EdgeInsets.fromLTRB(
                          Dimens.screenPadding,
                          Dimens.space3,
                          Dimens.screenPadding,
                          Dimens.space8,
                        ),
                        children: [build(scope)],
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Income vs expense, then the category trend over the same months
/// (DESIGN §8.5): one 6/12-month choice drives both.
class _TrendsTab extends StatefulWidget {
  const _TrendsTab({required this.scope});

  final ReportScope scope;

  @override
  State<_TrendsTab> createState() => _TrendsTabState();
}

class _TrendsTabState extends State<_TrendsTab> {
  var _months = 6;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TrendsView(
        scope: widget.scope,
        monthCount: _months,
        onMonthCount: (months) => setState(() => _months = months),
      ),
      const SizedBox(height: Dimens.cardGap),
      CategoryTrendView(scope: widget.scope, monthCount: _months),
    ],
  );
}

class _EmptyPeriod extends ConsumerWidget {
  const _EmptyPeriod({required this.scope});

  final ReportScope scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: EmptyState(
        icon: Symbols.donut_large_rounded,
        message: l10n.reports_empty(AppDateFormat.period(scope.period)),
        actionLabel: l10n.reports_go_to_data,
        onAction: () async {
          final period = await ref
              .read(statisticsProvider(scope).notifier)
              .lastPeriodWithData();
          if (period != null) {
            ref.read(selectedPeriodProvider.notifier).goTo(period);
          } else if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.reports_no_data_yet)));
          }
        },
      ),
    );
  }
}

class _TabBarHeader extends SliverPersistentHeaderDelegate {
  const _TabBarHeader(this.tabBar, this.background);

  final TabBar tabBar;
  final Color background;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) =>
      ColoredBox(color: background, child: tabBar);

  @override
  bool shouldRebuild(_TabBarHeader old) =>
      old.tabBar != tabBar || old.background != background;
}

/// `All accounts ▾`: limits every report to chosen accounts (DESIGN §8.5).
/// Hidden while there is only one account.
class _AccountScopeButton extends ConsumerWidget {
  const _AccountScopeButton({required this.scope});

  final ReportScope scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final accounts = ref.watch(accountsProvider()).value ?? const [];
    if (accounts.length < 2) return const SizedBox.shrink();
    final selected = scope.accountIds;
    return TextButton(
      key: const ValueKey('account-scope'),
      onPressed: () async {
        final picked = await showMultiSelectSheet(
          context,
          title: l10n.filter_account,
          selected: selected,
          options: [
            for (final a in accounts)
              (value: a.id, label: a.name, leading: AccountIcon(a)),
          ],
        );
        if (picked != null) {
          ref.read(reportScopeProvider.notifier).setAccounts(picked);
        }
      },
      child: Text(
        selected.isEmpty || selected.length == accounts.length
            ? l10n.reports_all_accounts
            : l10n.reports_some_accounts(selected.length),
      ),
    );
  }
}
