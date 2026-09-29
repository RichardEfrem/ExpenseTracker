import 'dart:async';

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/period/period_presentation.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/day_group.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/providers/activity_notifiers.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/widgets/activity_filter_bar.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/widgets/day_header.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/widgets/swipeable_transaction_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Transactions grouped by day, newest first, loading earlier months as you
/// scroll (DESIGN §8.3, PRD TX-09, SRCH-01…03).
class ActivityPage extends ConsumerStatefulWidget {
  const ActivityPage({this.initialFilter = TransactionFilter.none, super.key});

  /// From the route's query parameters (see `FilterQueryCodec`).
  final TransactionFilter initialFilter;

  @override
  ConsumerState<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends ConsumerState<ActivityPage> {
  late var _filter = widget.initialFilter;
  late final _search = TextEditingController(text: _filter.text);
  final _scroll = ScrollController();
  Timer? _debounce;

  /// How many period pages are loaded (the first plus earlier months).
  var _pages = 1;

  /// Rows swiped away but not yet gone from the database stream.
  final _hidden = <String>{};

  static const _loadAhead = 800.0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_maybeLoadMore);
  }

  @override
  void didUpdateWidget(ActivityPage old) {
    super.didUpdateWidget(old);
    if (widget.initialFilter != old.initialFilter) {
      _setFilter(widget.initialFilter);
      _search.text = widget.initialFilter.text;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _setFilter(TransactionFilter filter) => setState(() {
    _filter = filter;
    _pages = 1;
  });

  void _onSearch(String text) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => _setFilter(_filter.copyWith(text: text)),
    );
  }

  void _clearFilters() {
    _search.clear();
    _setFilter(TransactionFilter.none);
  }

  List<Period> _cursors(LocalDate today) {
    final settings = ref.read(settingsProvider).value ?? const AppSettings();
    final first = _filter.isActive
        ? Period.monthContaining(
            _filter.to ?? today,
            startDay: settings.monthStartDay,
          )
        : ref.read(selectedPeriodProvider);
    final cursors = [first];
    while (cursors.length < _pages) {
      cursors.add(
        Period.monthContaining(
          cursors.last.start.addDays(-1),
          startDay: settings.monthStartDay,
        ),
      );
    }
    return cursors;
  }

  /// Loads the previous month when the end of the list is near (or the
  /// list is too short to scroll).
  void _maybeLoadMore() {
    if (!mounted || !_scroll.hasClients) return;
    if (_scroll.position.extentAfter > _loadAhead) return;
    final today = LocalDate.today(ref.read(clockProvider));
    final last = _cursors(today).last;
    final page = ref.read(activityPageProvider(_filter, last)).value;
    if (page != null && page.hasMore) setState(() => _pages++);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final today = LocalDate.today(ref.watch(clockProvider));
    ref.watch(selectedPeriodProvider);
    ref.watch(settingsProvider);
    final cursors = _cursors(today);
    final multipleAccounts =
        (ref.watch(accountsProvider()).value?.length ?? 0) > 1;
    final pages = [
      for (final cursor in cursors)
        ref.watch(activityPageProvider(_filter, cursor)),
    ];

    // Forget hidden ids once the stream no longer has them, so an undo
    // shows the row again.
    final loadedIds = {
      for (final page in pages)
        for (final DayGroup day in page.value?.items ?? const [])
          for (final view in day.items) view.transaction.id,
    };
    _hidden.removeWhere((id) => !loadedIds.contains(id));

    final allLoaded = pages.every((p) => p.hasValue);
    final isEmpty =
        allLoaded &&
        pages.every((p) => p.value!.items.isEmpty) &&
        !pages.last.value!.hasMore;
    if (allLoaded && !isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeLoadMore());
    }

    final periodSummaryFilter = TransactionFilter(
      from: cursors.first.start,
      to: cursors.first.end,
    );

    return Scaffold(
      body: CustomScrollView(
        controller: _scroll,
        slivers: [
          SliverAppBar(title: Text(l10n.nav_activity), floating: true),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimens.screenPadding,
                0,
                Dimens.screenPadding,
                Dimens.space2,
              ),
              child: SearchBar(
                key: const ValueKey('activity-search'),
                controller: _search,
                hintText: l10n.activity_search_hint,
                leading: const Icon(Symbols.search_rounded),
                elevation: const WidgetStatePropertyAll(0),
                onChanged: _onSearch,
                trailing: [
                  if (_search.text.isNotEmpty)
                    IconButton(
                      tooltip: l10n.filter_clear,
                      icon: const Icon(Symbols.close_rounded),
                      onPressed: () {
                        _search.clear();
                        _setFilter(_filter.copyWith(text: ''));
                      },
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ActivityFilterBar(filter: _filter, onChanged: _setFilter),
          ),
          if (_filter.isActive)
            SliverToBoxAdapter(child: _ResultBar(filter: _filter))
          else ...[
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.space2),
                child: PeriodSelector(),
              ),
            ),
            SliverToBoxAdapter(
              child: _PeriodTotals(filter: periodSummaryFilter),
            ),
          ],
          if (isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: _filter.isActive
                    ? EmptyState(
                        icon: Symbols.filter_alt_off_rounded,
                        message: l10n.activity_no_results,
                        actionLabel: l10n.activity_clear_filters,
                        onAction: _clearFilters,
                      )
                    : EmptyState(
                        icon: Symbols.receipt_long_rounded,
                        message: l10n.activity_empty(
                          AppDateFormat.period(cursors.first),
                        ),
                        actionLabel: l10n.fab_add_expense,
                        onAction: () =>
                            context.push(AppPaths.addOfType('expense')),
                      ),
              ),
            )
          else
            for (final (i, cursor) in cursors.indexed) ...[
              if (i > 0)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      Dimens.screenPadding,
                      Dimens.space6,
                      Dimens.screenPadding,
                      0,
                    ),
                    child: Text(
                      AppDateFormat.period(cursor),
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ...switch (pages[i]) {
                AsyncData(:final value) => [
                  if (value.items.isEmpty && i == 0)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.screenPadding),
                        child: Text(
                          l10n.activity_period_empty,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  for (final day in value.items)
                    if (day.items.any(
                      (v) => !_hidden.contains(v.transaction.id),
                    ))
                      SliverMainAxisGroup(
                        key: ValueKey('day-${day.date}'),
                        slivers: [
                          PinnedHeaderSliver(
                            child: DayHeader(
                              date: day.date,
                              today: today,
                              net: day.net,
                            ),
                          ),
                          SliverList.list(
                            children: [
                              for (final view in day.items)
                                if (!_hidden.contains(view.transaction.id))
                                  SwipeableTransactionRow(
                                    key: ValueKey(view.transaction.id),
                                    view: view,
                                    showAccount: multipleAccounts,
                                    onDeleted: () => setState(
                                      () => _hidden.add(view.transaction.id),
                                    ),
                                  ),
                            ],
                          ),
                        ],
                      ),
                ],
                AsyncError(:final error) => [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.screenPadding),
                      child: Text(
                        error is Failure
                            ? failureMessage(l10n, error)
                            : l10n.failure_unexpected,
                      ),
                    ),
                  ),
                ],
                _ => [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(Dimens.space6),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              },
            ],
          // Room for the FAB over the last row.
          const SliverToBoxAdapter(child: SizedBox(height: 112)),
        ],
      ),
    );
  }
}

/// `In +Rp 8.500.000   Out −Rp 6.350.000` for the shown period.
class _PeriodTotals extends ConsumerWidget {
  const _PeriodTotals({required this.filter});

  final TransactionFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final summary = ref.watch(filterSummaryProvider(filter)).value;
    final label = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: Dimens.space4,
        runSpacing: Dimens.space1,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('${l10n.activity_in} ', style: label),
              MoneyText(summary?.income ?? 0, kind: AmountKind.income),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('${l10n.activity_out} ', style: label),
              MoneyText(summary?.expense ?? 0, kind: AmountKind.expense),
            ],
          ),
        ],
      ),
    );
  }
}

/// `23 transactions · −Rp 1.240.000` for the active filter (SRCH-03).
class _ResultBar extends ConsumerWidget {
  const _ResultBar({required this.filter});

  final TransactionFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final summary = ref.watch(filterSummaryProvider(filter)).value;
    if (summary == null) return const SizedBox(height: Dimens.minTouchTarget);
    return Container(
      key: const ValueKey('result-bar'),
      margin: const EdgeInsets.fromLTRB(
        Dimens.screenPadding,
        Dimens.space2,
        Dimens.screenPadding,
        0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space4,
        vertical: Dimens.space3,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '${l10n.activity_result_count(summary.count)} · ',
            style: theme.textTheme.bodyMedium,
          ),
          MoneyText(summary.net, kind: AmountKind.net),
        ],
      ),
    );
  }
}
