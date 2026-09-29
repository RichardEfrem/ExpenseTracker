import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/theme/motion.dart' as motion;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// One look for every chart (DESIGN §7.9): horizontal gridlines only in
/// `outline` at 50%, tabular axis text, inverse-surface tooltips, and
/// unselected marks dimmed to 40%.
class ChartStyle {
  ChartStyle.of(BuildContext context)
    : theme = Theme.of(context),
      finance = FinanceColors.of(context),
      reduceMotion = motion.reduceMotion(context);

  final ThemeData theme;
  final FinanceColors finance;
  final bool reduceMotion;

  static const dimmedAlpha = 0.4;

  TextStyle get axisText => theme.textTheme.labelSmall!
      .copyWith(color: theme.colorScheme.onSurfaceVariant)
      .tabular;

  FlGridData get grid => FlGridData(
    drawVerticalLine: false,
    getDrawingHorizontalLine: (_) => FlLine(
      color: theme.colorScheme.outline.withValues(alpha: 0.5),
      strokeWidth: 1,
    ),
  );

  FlBorderData get border => FlBorderData(show: false);

  Color get tooltipBackground => theme.colorScheme.inverseSurface;

  TextStyle get tooltipText => theme.textTheme.labelMedium!
      .copyWith(color: theme.colorScheme.onInverseSurface)
      .tabular;

  BorderRadius get tooltipRadius => BorderRadius.circular(Dimens.radiusSmall);

  /// [color] as drawn when another mark is selected.
  Color dim(Color color, {required bool dimmed}) =>
      dimmed ? color.withValues(alpha: dimmedAlpha) : color;

  /// Charts animate data changes over this; nothing when motion is off.
  Duration get swapDuration =>
      reduceMotion ? Duration.zero : motion.Motion.chartGrow;

  AxisTitles hidden() => const AxisTitles();
}
