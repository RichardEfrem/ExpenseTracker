import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// `Monthly on day 25`, `Every 2 weeks`.
String scheduleLabel(
  AppLocalizations l10n, {
  required RecurrenceFrequency frequency,
  required int interval,
  required int dayOfMonth,
}) => switch (frequency) {
  RecurrenceFrequency.daily => l10n.recurring_daily(interval),
  RecurrenceFrequency.weekly => l10n.recurring_weekly(interval),
  RecurrenceFrequency.monthly => l10n.recurring_monthly(interval, dayOfMonth),
  RecurrenceFrequency.yearly => l10n.recurring_yearly(interval),
};

String frequencyLabel(AppLocalizations l10n, RecurrenceFrequency frequency) =>
    switch (frequency) {
      RecurrenceFrequency.daily => l10n.recurring_frequency_daily,
      RecurrenceFrequency.weekly => l10n.recurring_frequency_weekly,
      RecurrenceFrequency.monthly => l10n.recurring_frequency_monthly,
      RecurrenceFrequency.yearly => l10n.recurring_frequency_yearly,
    };

String ruleScheduleLabel(AppLocalizations l10n, RuleView view) {
  final rule = view.rule;
  return scheduleLabel(
    l10n,
    frequency: rule.frequency,
    interval: rule.interval,
    dayOfMonth: rule.dayOfMonth ?? rule.startDate.day,
  );
}

/// The rule's name: its note (e.g. "Rent"), else the category, else the
/// type for transfers.
String ruleTitle(AppLocalizations l10n, RuleView view) =>
    view.rule.note ??
    view.category?.name ??
    transactionTypeLabel(l10n, view.rule.type);

/// The rule's category icon, or the transfer glyph.
class RuleIcon extends StatelessWidget {
  const RuleIcon(this.view, {super.key});

  final RuleView view;

  @override
  Widget build(BuildContext context) => switch (view.category) {
    final category? => CategoryIcon(category),
    null => IconCircle(
      icon: Symbols.swap_horiz_rounded,
      color: FinanceColors.of(context).transfer,
    ),
  };
}
