import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:expense_tracker/features/reports/daily/presentation/providers/daily_spending_notifier.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/core/widgets/chart_style.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/drill_down.dart';
import 'package:expense_tracker/core/widgets/grow_in.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "Daily spending, September 2026. Average 212 thousand rupiah. Highest
/// 28 September, 1 million rupiah."
String dailySummary(AppLocalizations l10n, DailySpending daily) {
  final period = AppDateFormat.period(daily.period);
  if (daily.isEmpty) {
    return l10n.chart_summary_empty(l10n.daily_title, period);
  }
  final (peakDay, peak) = daily.days.reduce((a, b) => b.$2 > a.$2 ? b : a);
  return l10n.daily_summary(
    period,
    moneySemantics(l10n, daily.average ?? 0),
    AppDateFormat.dayMonthLong(peakDay),
    moneySemantics(l10n, peak),
  );
}

/// Expense per day with the average as a dashed line; today outlined
/// (PRD RPT-03).
class DailyView extends ConsumerStatefulWidget {
  const DailyView({required this.scope, super.key});

  final ReportScope scope;

  @override
  ConsumerState<DailyView> createState() => _DailyViewState();
}

class _DailyViewState extends ConsumerState<DailyView> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = ChartStyle.of(context);
    final daily = ref.watch(dailySpendingProvider(widget.scope)).value;
    if (daily == null) {
      return ReportCard(
        title: l10n.daily_title,
        child: const SizedBox(
          height: 220,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    final days = daily.days;
    final average = daily.average;
    final maxY = days.fold(0, (m, d) => d.$2 > m ? d.$2 : m);
    final showEvery = days.length <= 7 ? 1 : (days.length <= 31 ? 5 : 30);

    void tap(int i) {
      if (_selected == i) {
        final day = days[i].$1;
        drillDown(
          context,
          periodFilter(
            Period.custom(day, day),
            types: {TransactionType.expense},
          ),
        );
      } else {
        setState(() => _selected = i);
      }
    }

    return ReportCard(
      title: l10n.daily_title,
      child: Semantics(
        label: dailySummary(l10n, daily),
        child: ExcludeSemantics(
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: GrowIn(
                  builder: (context, t) => BarChart(
                    duration: style.swapDuration,
                    BarChartData(
                      maxY: (maxY == 0 ? 1000 : maxY) * 1.15,
                      gridData: style.grid,
                      borderData: style.border,
                      alignment: BarChartAlignment.spaceAround,
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
                            getTitlesWidget: (value, meta) {
                              final i = value.round();
                              if (i < 0 ||
                                  i >= days.length ||
                                  (i % showEvery != 0 &&
                                      i != days.length - 1)) {
                                return const SizedBox.shrink();
                              }
                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  '${days[i].$1.day}',
                                  style: style.axisText,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          if (average != null && average > 0)
                            HorizontalLine(
                              y: average.toDouble(),
                              color: style.theme.colorScheme.onSurfaceVariant,
                              strokeWidth: 1,
                              dashArray: const [4, 4],
                              label: HorizontalLineLabel(
                                show: true,
                                alignment: Alignment.topRight,
                                style: style.axisText,
                                labelResolver: (_) => l10n.daily_average(
                                  MoneyFormat.compact(average),
                                ),
                              ),
                            ),
                        ],
                      ),
                      barTouchData: BarTouchData(
                        handleBuiltInTouches: false,
                        touchCallback: (event, response) {
                          final i = response?.spot?.touchedBarGroupIndex;
                          if (event is FlTapUpEvent && i != null) tap(i);
                        },
                      ),
                      barGroups: [
                        for (final (i, (day, amount)) in days.indexed)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: amount * t,
                                width: days.length > 31 ? 2 : 6,
                                color: style.dim(
                                  style.finance.expense.withValues(alpha: 0.7),
                                  dimmed: _selected != null && _selected != i,
                                ),
                                borderSide: day == daily.today
                                    ? BorderSide(
                                        color: style.finance.expense,
                                        width: 1.5,
                                      )
                                    : BorderSide.none,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(2),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_selected case final i?)
                Padding(
                  padding: const EdgeInsets.only(top: Dimens.space2),
                  child: Text(
                    '${AppDateFormat.weekdayDayMonth(days[i].$1)} · '
                    '${MoneyFormat.ofKind(days[i].$2, AmountKind.expense)} · '
                    '${l10n.chart_tap_again}',
                    style: style.axisText,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
