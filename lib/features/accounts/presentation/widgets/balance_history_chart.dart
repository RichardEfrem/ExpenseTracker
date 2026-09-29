import 'dart:math' as math;

import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/chart_style.dart';
import 'package:expense_tracker/core/widgets/grow_in.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// "Balance over time, last 6 months. Cash: 1 million rupiah, BCA: …" at
/// the latest point.
String balanceHistorySummary(AppLocalizations l10n, BalanceHistory history) {
  final parts = [
    for (final a in history.accounts)
      '${a.name}: ${moneySemantics(l10n, history.series[a.id]!.last)}',
  ];
  return '${l10n.accounts_chart_summary(history.dates.length)} ${parts.join(', ')}.';
}

/// One line per account, in its color (PRD RPT-07, DESIGN §8.7).
class BalanceHistoryChart extends StatelessWidget {
  const BalanceHistoryChart({required this.history, super.key});

  final BalanceHistory history;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = ChartStyle.of(context);
    final values = [for (final s in history.series.values) ...s];
    final maxY = values.isEmpty ? 1000 : values.reduce(math.max);
    final minY = values.isEmpty ? 0 : math.min(0, values.reduce(math.min));
    final span = math.max(1, maxY - minY);

    return Semantics(
      label: balanceHistorySummary(l10n, history),
      child: ExcludeSemantics(
        child: SizedBox(
          height: 200,
          child: GrowIn(
            builder: (context, t) => LineChart(
              duration: style.swapDuration,
              LineChartData(
                minY: minY - span * 0.1,
                maxY: maxY + span * 0.1,
                gridData: style.grid,
                borderData: style.border,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => style.tooltipBackground,
                    getTooltipItems: (spots) => [
                      for (final spot in spots)
                        LineTooltipItem(
                          '${history.accounts[spot.barIndex].name} '
                          '${MoneyFormat.compact(spot.y.round())}',
                          style.tooltipText,
                        ),
                    ],
                  ),
                ),
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
                      interval: 1,
                      reservedSize: 24,
                      getTitlesWidget: (value, meta) {
                        final i = value.round();
                        if (i < 0 || i >= history.dates.length || value != i) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            AppDateFormat.monthShort(history.dates[i]),
                            style: style.axisText,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  for (final account in history.accounts)
                    LineChartBarData(
                      spots: [
                        for (final (i, v)
                            in history.series[account.id]!.indexed)
                          FlSpot(i.toDouble(), v * t),
                      ],
                      color: style.finance.category(account.color),
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
