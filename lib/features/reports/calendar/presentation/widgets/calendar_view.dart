import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/reports/calendar/domain/entities/cash_flow_calendar.dart';
import 'package:expense_tracker/features/reports/calendar/presentation/providers/cash_flow_calendar_notifier.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/drill_down.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "28 September, net minus 128 thousand rupiah" (DESIGN §9).
String calendarDayLabel(AppLocalizations l10n, LocalDate day, int? net) {
  final date = AppDateFormat.dayMonthLong(day);
  return net == null
      ? l10n.calendar_day_empty(date)
      : l10n.calendar_day_label(
          date,
          moneySemantics(l10n, net, AmountKind.net),
        );
}

/// Tint opacity per step 1…5 over the card surface.
const _stepAlphas = [0.14, 0.28, 0.42, 0.58, 0.76];

/// The background of a day at [step] (−5 … 5); the card surface for 0.
Color calendarTint(BuildContext context, int step) {
  final theme = Theme.of(context);
  final surface = theme.cardTheme.color ?? theme.colorScheme.surface;
  if (step == 0) return surface;
  final finance = FinanceColors.of(context);
  final base = step > 0 ? finance.income : finance.expense;
  return Color.alphaBlend(
    base.withValues(alpha: _stepAlphas[step.abs() - 1]),
    surface,
  );
}

/// Black or white, whichever reads better on [background].
Color onTint(Color background) =>
    background.computeLuminance() > 0.179 ? Colors.black : Colors.white;

/// Month grid tinted by daily net (PRD RPT-06): 5 green steps for money
/// in, 5 red for money out; tap a day to see its transactions.
class CalendarView extends ConsumerWidget {
  const CalendarView({required this.scope, super.key});

  final ReportScope scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final calendar = ref.watch(cashFlowCalendarProvider(scope)).value;
    final weekStart =
        ref.watch(settingsProvider).value?.weekStart ??
        const AppSettings().weekStart;
    if (calendar == null) {
      return ReportCard(
        title: l10n.calendar_title,
        child: const SizedBox(
          height: 240,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    final header = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return ReportCard(
      title: l10n.calendar_title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(
            child: Row(
              children: [
                for (var i = 0; i < 7; i++)
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppDateFormat.weekdayShort((weekStart - 1 + i) % 7 + 1),
                        style: header,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Dimens.space1),
          for (final block in calendar.blocks(weekStart)) ...[
            if (block.month case final month?)
              Padding(
                padding: const EdgeInsets.only(
                  top: Dimens.space3,
                  bottom: Dimens.space1,
                ),
                child: Semantics(
                  header: true,
                  child: Text(
                    AppDateFormat.monthYear(month),
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
            for (var row = 0; row < block.cells.length; row += 7)
              Row(
                children: [
                  for (final day in block.cells.sublist(row, row + 7))
                    Expanded(
                      child: day == null
                          ? const SizedBox.shrink()
                          : _DayCell(
                              day: day,
                              calendar: calendar,
                              onTap: () => drillDown(
                                context,
                                periodFilter(Period.custom(day, day)),
                              ),
                            ),
                    ),
                ],
              ),
          ],
          const SizedBox(height: Dimens.space3),
          const _Legend(),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.calendar,
    required this.onTap,
  });

  final LocalDate day;
  final CashFlowCalendar calendar;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final net = calendar.netByDay[day];
    final background = calendarTint(context, calendar.stepOf(day));
    final foreground = net == null
        ? theme.colorScheme.onSurfaceVariant
        : onTint(background);
    final isToday = day == calendar.today;
    return Semantics(
      key: ValueKey('calendar-${day.toIso()}'),
      // Its own stop for every day, also empty ones.
      container: true,
      button: net != null,
      label: calendarDayLabel(l10n, day, net),
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: isToday
                ? BorderSide(color: theme.colorScheme.primary, width: 1.5)
                : BorderSide.none,
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: net == null ? null : onTap,
            child: AspectRatio(
              aspectRatio: 0.9,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.space1 / 2),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${day.day}',
                        style: theme.textTheme.labelMedium!.copyWith(
                          color: foreground,
                          fontWeight: isToday ? FontWeight.w700 : null,
                        ),
                      ),
                      Text(
                        net == null ? '' : MoneyFormat.compactSigned(net),
                        style: theme.textTheme.labelSmall!
                            .copyWith(color: foreground)
                            .tabular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// `Out ■■■■■ ■■■■■ In`: strongest red to strongest green.
class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final text = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    Widget swatch(int step) => Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: calendarTint(context, step),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: theme.colorScheme.outline, width: 0.5),
      ),
    );
    return ExcludeSemantics(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: Dimens.space1,
        children: [
          Text(l10n.activity_out, style: text),
          for (var step = -CashFlowCalendar.steps; step < 0; step++)
            swatch(step),
          const SizedBox(width: Dimens.space1),
          for (var step = 1; step <= CashFlowCalendar.steps; step++)
            swatch(step),
          Text(l10n.activity_in, style: text),
        ],
      ),
    );
  }
}
