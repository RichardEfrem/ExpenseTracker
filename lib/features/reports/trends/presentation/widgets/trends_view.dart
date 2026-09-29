import 'dart:math' as math;

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/core/widgets/chart_style.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/drill_down.dart';
import 'package:expense_tracker/core/widgets/grow_in.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:expense_tracker/features/reports/trends/domain/entities/month_totals.dart';
import 'package:expense_tracker/features/reports/trends/presentation/providers/trends_notifier.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Label for a month bucket: `Sep`, or `25 Aug` for custom start days.
String monthBucketLabel(MonthTotals month) => month.period.isCalendarMonth
    ? AppDateFormat.monthShort(month.period.start)
    : AppDateFormat.dayMonth(month.period.start);

/// "Income vs expense, last 6 months. Apr: income …, expense …, net …."
String trendsSummary(AppLocalizations l10n, List<MonthTotals> months) {
  final parts = [
    for (final m in months)
      l10n.trends_summary_month(
        monthBucketLabel(m),
        moneySemantics(l10n, m.income),
        moneySemantics(l10n, m.expense),
        moneySemantics(l10n, m.net),
      ),
  ];
  return '${l10n.trends_summary_title(months.length)} ${parts.join(' ')}';
}

/// Income vs expense per month with the net as a line (PRD RPT-02).
class TrendsView extends ConsumerStatefulWidget {
  const TrendsView({required this.scope, super.key});

  final ReportScope scope;

  @override
  ConsumerState<TrendsView> createState() => _TrendsViewState();
}

class _TrendsViewState extends ConsumerState<TrendsView> {
  var _months = 6;
  int? _selected;

  void _tap(int index, List<MonthTotals> months) {
    if (_selected == index) {
      drillDown(context, periodFilter(months[index].period));
    } else {
      setState(() => _selected = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final months = ref.watch(trendsProvider(widget.scope, _months)).value;
    return ReportCard(
      title: l10n.trends_title,
      trailing: SegmentedButton<int>(
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: [
          ButtonSegment(value: 6, label: Text(l10n.trends_months(6))),
          ButtonSegment(value: 12, label: Text(l10n.trends_months(12))),
        ],
        selected: {_months},
        onSelectionChanged: (s) => setState(() {
          _months = s.single;
          _selected = null;
        }),
      ),
      child: months == null
          ? const SizedBox(
              height: 220,
              child: Center(child: CircularProgressIndicator()),
            )
          : Semantics(
              label: trendsSummary(l10n, months),
              child: ExcludeSemantics(
                child: Column(
                  children: [
                    _Chart(
                      months: months,
                      selected: _selected,
                      onTap: (i) => _tap(i, months),
                    ),
                    const SizedBox(height: Dimens.space3),
                    const _Legend(),
                  ],
                ),
              ),
            ),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.months,
    required this.selected,
    required this.onTap,
  });

  final List<MonthTotals> months;
  final int? selected;
  final ValueChanged<int> onTap;

  static const _axisReserved = 44.0;
  static const _bottomReserved = 24.0;

  @override
  Widget build(BuildContext context) {
    final style = ChartStyle.of(context);
    final maxBar = months.fold(
      0,
      (m, t) => math.max(m, math.max(t.income, t.expense)),
    );
    final minNet = months.fold(0, (m, t) => math.min(m, t.net));
    final top = (maxBar == 0 ? 1000 : maxBar) * 1.1;
    final bottom = minNet < 0 ? minNet * 1.1 : 0.0;
    final barWidth = months.length > 6 ? 6.0 : 10.0;

    AxisTitles left(bool show) => AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _axisReserved,
        getTitlesWidget: (value, meta) => show
            ? SideTitleWidget(
                meta: meta,
                child: Text(
                  MoneyFormat.compactNumber(value.round()),
                  style: style.axisText,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
    AxisTitles bottomTitles(bool show) => AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _bottomReserved,
        getTitlesWidget: (value, meta) {
          final i = value.round();
          if (!show || i < 0 || i >= months.length || value != i) {
            return const SizedBox.shrink();
          }
          return SideTitleWidget(
            meta: meta,
            child: Text(monthBucketLabel(months[i]), style: style.axisText),
          );
        },
      ),
    );
    final titles = FlTitlesData(
      leftTitles: left(true),
      bottomTitles: bottomTitles(true),
      rightTitles: style.hidden(),
      topTitles: style.hidden(),
    );

    return SizedBox(
      height: 220,
      child: GrowIn(
        builder: (context, t) => Stack(
          children: [
            BarChart(
              duration: style.swapDuration,
              BarChartData(
                minY: bottom,
                maxY: top,
                alignment: BarChartAlignment.spaceAround,
                gridData: style.grid,
                borderData: style.border,
                titlesData: titles,
                barTouchData: BarTouchData(
                  handleBuiltInTouches: false,
                  touchCallback: (event, response) {
                    final i = response?.spot?.touchedBarGroupIndex;
                    if (event is FlTapUpEvent && i != null) onTap(i);
                  },
                ),
                barGroups: [
                  for (final (i, m) in months.indexed)
                    BarChartGroupData(
                      x: i,
                      barsSpace: 2,
                      showingTooltipIndicators: const [],
                      barRods: [
                        BarChartRodData(
                          toY: m.income * t,
                          width: barWidth,
                          color: style.dim(
                            style.finance.income,
                            dimmed: selected != null && selected != i,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(3),
                          ),
                        ),
                        BarChartRodData(
                          toY: m.expense * t,
                          width: barWidth,
                          color: style.dim(
                            style.finance.expense,
                            dimmed: selected != null && selected != i,
                          ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(3),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            IgnorePointer(
              child: LineChart(
                duration: style.swapDuration,
                LineChartData(
                  minX: -0.5,
                  maxX: months.length - 0.5,
                  minY: bottom,
                  maxY: top,
                  gridData: const FlGridData(show: false),
                  borderData: style.border,
                  lineTouchData: const LineTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: left(false),
                    bottomTitles: bottomTitles(false),
                    rightTitles: style.hidden(),
                    topTitles: style.hidden(),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (final (i, m) in months.indexed)
                          FlSpot(i.toDouble(), m.net * t),
                      ],
                      color: style.theme.colorScheme.primary,
                      barWidth: 2,
                      dotData: const FlDotData(),
                    ),
                  ],
                ),
              ),
            ),
            if (selected != null)
              Align(
                alignment: Alignment.topCenter,
                child: _Tooltip(month: months[selected!]),
              ),
          ],
        ),
      ),
    );
  }
}

class _Tooltip extends StatelessWidget {
  const _Tooltip({required this.month});

  final MonthTotals month;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = ChartStyle.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: style.tooltipBackground,
        borderRadius: style.tooltipRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space3,
          vertical: Dimens.space2,
        ),
        child: Text(
          '${AppDateFormat.period(month.period)}\n'
          '${l10n.activity_in} ${MoneyFormat.ofKind(month.income, AmountKind.income)}  '
          '${l10n.activity_out} ${MoneyFormat.ofKind(month.expense, AmountKind.expense)}\n'
          '${l10n.trends_net} ${MoneyFormat.signed(month.net)}\n'
          '${l10n.chart_tap_again}',
          style: style.tooltipText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = ChartStyle.of(context);
    Widget item(Color color, String label, {bool dot = false}) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: dot ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: dot ? null : BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: Dimens.space1),
        Text(label, style: style.axisText),
      ],
    );
    return Wrap(
      spacing: Dimens.space4,
      alignment: WrapAlignment.center,
      children: [
        item(style.finance.income, l10n.type_income),
        item(style.finance.expense, l10n.type_expense),
        item(style.theme.colorScheme.primary, l10n.trends_net, dot: true),
      ],
    );
  }
}
