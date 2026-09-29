import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/recurring/presentation/widgets/recurring_labels.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

typedef RepeatChoice = ({
  RecurrenceFrequency frequency,
  int interval,
  int dayOfMonth,
});

/// Daily / Weekly / Monthly on day N / Yearly, every N (DESIGN §8.9). The
/// choice, or null when dismissed.
Future<RepeatChoice?> showRepeatSheet(
  BuildContext context, {
  required RepeatChoice initial,
}) => showModalBottomSheet<RepeatChoice>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => _RepeatSheet(initial: initial),
);

class _RepeatSheet extends StatefulWidget {
  const _RepeatSheet({required this.initial});

  final RepeatChoice initial;

  @override
  State<_RepeatSheet> createState() => _RepeatSheetState();
}

class _RepeatSheetState extends State<_RepeatSheet> {
  late var _frequency = widget.initial.frequency;
  late var _interval = widget.initial.interval;
  late var _day = widget.initial.dayOfMonth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimens.screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.recurring_repeat, style: theme.textTheme.titleLarge),
          const SizedBox(height: Dimens.space4),
          Wrap(
            spacing: Dimens.space2,
            runSpacing: Dimens.space2,
            children: [
              for (final f in RecurrenceFrequency.values)
                ChoiceChip(
                  key: ValueKey('frequency-${f.name}'),
                  label: Text(frequencyLabel(l10n, f)),
                  selected: _frequency == f,
                  onSelected: (_) => setState(() => _frequency = f),
                ),
            ],
          ),
          const SizedBox(height: Dimens.space4),
          _Stepper(
            name: 'interval',
            label: l10n.recurring_interval,
            value: scheduleLabel(
              l10n,
              frequency: _frequency,
              interval: _interval,
              dayOfMonth: _day,
            ),
            onLess: _interval > 1 ? () => setState(() => _interval--) : null,
            onMore: _interval < RecurringRuleInput.maxInterval
                ? () => setState(() => _interval++)
                : null,
          ),
          if (_frequency == RecurrenceFrequency.monthly) ...[
            _Stepper(
              name: 'day',
              label: l10n.recurring_day_of_month,
              value: l10n.recurring_day_value(_day),
              onLess: _day > 1 ? () => setState(() => _day--) : null,
              onMore: _day < 31 ? () => setState(() => _day++) : null,
            ),
            Text(
              l10n.recurring_day_hint,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: Dimens.space4),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FilledButton(
              key: const ValueKey('repeat-done'),
              onPressed: () => Navigator.pop<RepeatChoice>(context, (
                frequency: _frequency,
                interval: _interval,
                dayOfMonth: _day,
              )),
              child: Text(l10n.common_done),
            ),
          ),
        ],
      ),
    );
  }
}

/// `label` over `value`, with − and + buttons.
class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.name,
    required this.label,
    required this.value,
    required this.onLess,
    required this.onMore,
  });

  /// Key prefix for the buttons.
  final String name;
  final String label;
  final String value;
  final VoidCallback? onLess;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
      child: Row(
        children: [
          Expanded(
            child: MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(value, style: theme.textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          IconButton.outlined(
            key: ValueKey('$name-less'),
            tooltip: l10n.recurring_less,
            icon: const Icon(Symbols.remove_rounded),
            onPressed: onLess,
          ),
          const SizedBox(width: Dimens.space2),
          IconButton.outlined(
            key: ValueKey('$name-more'),
            tooltip: l10n.recurring_more,
            icon: const Icon(Symbols.add_rounded),
            onPressed: onMore,
          ),
        ],
      ),
    );
  }
}
