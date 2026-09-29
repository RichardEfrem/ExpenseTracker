import 'dart:math' as math;

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/chart_style.dart';
import 'package:expense_tracker/core/widgets/grow_in.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:expense_tracker/features/reports/category_trend/presentation/providers/category_trend_notifier.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:expense_tracker/features/reports/trends/presentation/widgets/trends_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "Category trend, last 6 months. Food & Drinks: Apr 1 million rupiah, …"
String categoryTrendSummary(
  AppLocalizations l10n,
  CategoryTrend trend,
  List<CategorySeries> lines,
) {
  final parts = [
    for (final line in lines)
      l10n.category_trend_summary_series(
        line.category.name,
        [
          for (final (i, amount) in line.amounts.indexed)
            l10n.category_trend_summary_point(
              monthBucketLabel(trend.months[i]),
              moneySemantics(l10n, amount),
            ),
        ].join(', '),
      ),
  ];
  return [
    l10n.category_trend_summary_title(trend.months.length),
    ...parts,
  ].join(' ');
}

/// One line per picked category over the Trends months (PRD RPT-04):
/// multi-select chips, up to [CategoryTrend.maxLines], in category colors.
class CategoryTrendView extends ConsumerStatefulWidget {
  const CategoryTrendView({
    required this.scope,
    required this.monthCount,
    super.key,
  });

  final ReportScope scope;
  final int monthCount;

  @override
  ConsumerState<CategoryTrendView> createState() => _CategoryTrendViewState();
}

class _CategoryTrendViewState extends ConsumerState<CategoryTrendView> {
  /// Null until the user picks: the default selection then applies.
  Set<String>? _picked;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = ChartStyle.of(context);
    final trend = ref
        .watch(categoryTrendProvider(widget.scope, widget.monthCount))
        .value;
    if (trend == null) {
      return ReportCard(
        title: l10n.category_trend_title,
        child: const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    final picked = _picked ?? trend.defaultSelection;
    final lines = trend.selected(picked);
    final full = lines.length >= CategoryTrend.maxLines;

    Widget chip(CategorySeries series) {
      final id = series.category.id;
      final selected = picked.contains(id);
      return FilterChip(
        key: ValueKey('trend-chip-$id'),
        avatar: CircleAvatar(
          backgroundColor: style.finance.category(series.category.color),
          radius: 6,
        ),
        label: Text(series.category.name),
        selected: selected,
        showCheckmark: false,
        // At the limit, only picked chips can change (to unpick).
        onSelected: selected || !full
            ? (on) => setState(
                () =>
                    _picked = on ? {...picked, id} : ({...picked}..remove(id)),
              )
            : null,
      );
    }

    return ReportCard(
      title: l10n.category_trend_title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (lines.isEmpty)
            Padding(
              padding: const EdgeInsets.all(Dimens.space4),
              child: Text(
                l10n.category_trend_pick(CategoryTrend.maxLines),
                textAlign: TextAlign.center,
              ),
            )
          else
            Semantics(
              label: categoryTrendSummary(l10n, trend, lines),
              child: ExcludeSemantics(
                child: _Chart(trend: trend, lines: lines),
              ),
            ),
          const SizedBox(height: Dimens.space3),
          Wrap(
            spacing: Dimens.space2,
            runSpacing: Dimens.space2,
            children: [for (final series in trend.series) chip(series)],
          ),
        ],
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({required this.trend, required this.lines});

  final CategoryTrend trend;
  final List<CategorySeries> lines;

  @override
  Widget build(BuildContext context) {
    final style = ChartStyle.of(context);
    final months = trend.months;
    final max = lines.fold(
      0,
      (m, line) => math.max(m, line.amounts.fold(0, math.max)),
    );
    final showEvery = months.length > 6 ? 2 : 1;
    return SizedBox(
      height: 200,
      child: GrowIn(
        builder: (context, t) => LineChart(
          duration: style.swapDuration,
          LineChartData(
            minX: 0,
            maxX: math.max(months.length - 1, 1).toDouble(),
            minY: 0,
            maxY: (max == 0 ? 1000 : max) * 1.15,
            gridData: style.grid,
            borderData: style.border,
            lineTouchData: const LineTouchData(enabled: false),
            titlesData: FlTitlesData(
              rightTitles: style.hidden(),
              topTitles: style.hidden(),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 44,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: Text(
                      MoneyFormat.compactNumber(value.round()),
                      style: style.axisText,
                    ),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final i = value.round();
                    if (value != i ||
                        i < 0 ||
                        i >= months.length ||
                        (i % showEvery != 0 && i != months.length - 1)) {
                      return const SizedBox.shrink();
                    }
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        monthBucketLabel(months[i]),
                        style: style.axisText,
                      ),
                    );
                  },
                ),
              ),
            ),
            lineBarsData: [
              for (final line in lines)
                LineChartBarData(
                  spots: [
                    for (final (i, amount) in line.amounts.indexed)
                      FlSpot(i.toDouble(), amount * t),
                  ],
                  color: style.finance.category(line.category.color),
                  barWidth: 2,
                  dotData: const FlDotData(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
