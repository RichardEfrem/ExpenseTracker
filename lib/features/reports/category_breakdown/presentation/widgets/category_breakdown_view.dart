import 'dart:math' as math;

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/adaptive_layout.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/category_breakdown/presentation/providers/category_breakdown_notifier.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/core/widgets/chart_style.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/drill_down.dart';
import 'package:expense_tracker/core/widgets/grow_in.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "Spending by category, September 2026. Food & Drinks 42 percent, 1
/// million 840 thousand rupiah. …" (DESIGN §7.9).
String categoryBreakdownSummary(
  AppLocalizations l10n,
  CategoryBreakdown breakdown,
  String periodLabel,
) {
  final title = breakdown.type == CategoryType.expense
      ? l10n.breakdown_title_expense
      : l10n.breakdown_title_income;
  if (breakdown.totals.isEmpty) {
    return l10n.chart_summary_empty(title, periodLabel);
  }
  final parts = [
    for (final slice in breakdown.donut)
      l10n.chart_summary_share(
        slice.category?.name ?? l10n.breakdown_other(slice.otherCount),
        (slice.share * 100).round(),
        moneySemantics(l10n, slice.amount),
      ),
  ];
  return '${l10n.chart_summary_title(title, periodLabel)} ${parts.join(' ')}';
}

/// Category breakdown (PRD RPT-01): Expense/Income toggle, donut with the
/// total in the hole, ranked list.
class CategoryBreakdownView extends ConsumerStatefulWidget {
  const CategoryBreakdownView({required this.scope, super.key});

  final ReportScope scope;

  @override
  ConsumerState<CategoryBreakdownView> createState() =>
      _CategoryBreakdownViewState();
}

class _CategoryBreakdownViewState extends ConsumerState<CategoryBreakdownView> {
  var _type = CategoryType.expense;
  int? _selected;

  void _drill(DonutSlice slice) => drillDown(
    context,
    periodFilter(widget.scope.period, categoryIds: slice.categoryIds),
  );

  void _tap(int index, List<DonutSlice> slices) {
    if (_selected == index) {
      _drill(slices[index]);
    } else {
      setState(() => _selected = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final breakdown = ref
        .watch(categoryBreakdownProvider(widget.scope, _type))
        .value;
    return ReportCard(
      title: _type == CategoryType.expense
          ? l10n.breakdown_title_expense
          : l10n.breakdown_title_income,
      trailing: SegmentedButton<CategoryType>(
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: [
          ButtonSegment(
            value: CategoryType.expense,
            label: Text(l10n.type_expense),
          ),
          ButtonSegment(
            value: CategoryType.income,
            label: Text(l10n.type_income),
          ),
        ],
        selected: {_type},
        onSelectionChanged: (s) => setState(() {
          _type = s.single;
          _selected = null;
        }),
      ),
      child: breakdown == null
          ? const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
          : breakdown.totals.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(Dimens.space6),
              child: Text(l10n.breakdown_empty, textAlign: TextAlign.center),
            )
          : Semantics(
              label: categoryBreakdownSummary(
                l10n,
                breakdown,
                AppDateFormat.period(widget.scope.period),
              ),
              child: Column(
                children: [
                  ExcludeSemantics(
                    child: _Donut(
                      breakdown: breakdown,
                      selected: _selected,
                      onTap: (i) => _tap(i, breakdown.donut),
                    ),
                  ),
                  const SizedBox(height: Dimens.space4),
                  for (final total in breakdown.totals)
                    _RankedRow(
                      category: total.category,
                      amount: total.amount,
                      share: breakdown.shareOf(total.amount),
                      count: total.count,
                      type: _type,
                      onTap: () => drillDown(
                        context,
                        periodFilter(
                          widget.scope.period,
                          categoryIds: {total.category.id},
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

class _Donut extends StatelessWidget {
  const _Donut({
    required this.breakdown,
    required this.selected,
    required this.onTap,
  });

  final CategoryBreakdown breakdown;
  final int? selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = ChartStyle.of(context);
    final slices = breakdown.donut;
    final kind = breakdown.type == CategoryType.expense
        ? AmountKind.expense
        : AmountKind.income;
    final focus = selected == null ? null : slices[selected!];

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, 240.0);
        final outer = size / 2;
        final inner = outer * 0.56;
        return SizedBox(
          height: size,
          child: GrowIn(
            builder: (context, t) => Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  duration: style.swapDuration,
                  PieChartData(
                    startDegreeOffset: -90,
                    sectionsSpace: 2,
                    centerSpaceRadius: inner,
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {
                        final index =
                            response?.touchedSection?.touchedSectionIndex;
                        if (event is FlTapUpEvent &&
                            index != null &&
                            index >= 0) {
                          onTap(index);
                        }
                      },
                    ),
                    sections: [
                      for (final (i, slice) in slices.indexed)
                        PieChartSectionData(
                          value: slice.amount * t,
                          color: style.dim(
                            style.finance.category(
                              slice.category?.color ?? PaletteColor.neutral,
                            ),
                            dimmed: selected != null && selected != i,
                          ),
                          radius: outer - inner,
                          showTitle: false,
                        ),
                      if (t < 1)
                        PieChartSectionData(
                          value: breakdown.total * (1 - t),
                          color: Colors.transparent,
                          radius: outer - inner,
                          showTitle: false,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: inner * 1.6,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        focus == null
                            ? l10n.breakdown_total
                            : focus.category?.name ??
                                  l10n.breakdown_other(focus.otherCount),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: style.axisText,
                      ),
                      MoneyText(
                        focus?.amount ?? breakdown.total,
                        kind: kind,
                        hero: true,
                        alignment: Alignment.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (focus != null)
                        Text(
                          MoneyFormat.percent(focus.share, decimals: 0),
                          style: style.axisText,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RankedRow extends StatelessWidget {
  const _RankedRow({
    required this.category,
    required this.amount,
    required this.share,
    required this.count,
    required this.type,
    required this.onTap,
  });

  final Category category;
  final int amount;
  final double share;
  final int count;
  final CategoryType type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final style = ChartStyle.of(context);
    final secondary = theme.textTheme.labelSmall!
        .copyWith(color: theme.colorScheme.onSurfaceVariant)
        .tabular;
    final bar = ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: LinearProgressIndicator(
        value: share,
        minHeight: 4,
        color: style.finance.category(category.color),
        backgroundColor: theme.colorScheme.surfaceContainer,
      ),
    );
    final amountText = MoneyText(
      amount,
      kind: type == CategoryType.expense
          ? AmountKind.expense
          : AmountKind.income,
    );
    final stats = Text(
      '${MoneyFormat.percent(share, decimals: 0)} · '
      '${l10n.breakdown_count(count)}',
      style: secondary,
    );
    final stacked = useStackedLayout(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
        child: Row(
          children: [
            CategoryIcon(category),
            const SizedBox(width: Dimens.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: Dimens.space1),
                  bar,
                  if (stacked) ...[
                    const SizedBox(height: Dimens.space1),
                    Wrap(
                      spacing: Dimens.space2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [amountText, stats],
                    ),
                  ],
                ],
              ),
            ),
            if (!stacked) ...[
              const SizedBox(width: Dimens.space3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [amountText, stats],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
