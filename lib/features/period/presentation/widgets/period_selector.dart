import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/period/presentation/providers/selected_period_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// `‹  September 2026  ›` (DESIGN §7.1). The label opens a sheet to pick
/// Week · Month · Year · Custom.
class PeriodSelector extends ConsumerWidget {
  const PeriodSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final period = ref.watch(selectedPeriodProvider);
    final notifier = ref.read(selectedPeriodProvider.notifier);
    final today = LocalDate.today(ref.watch(clockProvider));
    final canGoNext = !period.next().isFuture(today);

    return Row(
      children: [
        IconButton(
          key: const ValueKey('period-previous'),
          tooltip: l10n.period_previous,
          icon: const Icon(Symbols.chevron_left_rounded),
          onPressed: notifier.previous,
        ),
        Expanded(
          child: TextButton(
            key: const ValueKey('period-label'),
            onPressed: () => showPeriodSheet(context),
            child: Text(
              AppDateFormat.period(period),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          key: const ValueKey('period-next'),
          tooltip: l10n.period_next,
          icon: const Icon(Symbols.chevron_right_rounded),
          onPressed: canGoNext ? notifier.next : null,
        ),
      ],
    );
  }
}

Future<void> showPeriodSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const _PeriodSheet(),
    );

class _PeriodSheet extends ConsumerStatefulWidget {
  const _PeriodSheet();

  @override
  ConsumerState<_PeriodSheet> createState() => _PeriodSheetState();
}

class _PeriodSheetState extends ConsumerState<_PeriodSheet> {
  late var _kind = ref.read(selectedPeriodProvider).kind;
  late var _year = ref.read(selectedPeriodProvider).end.year;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final period = ref.watch(selectedPeriodProvider);
    final notifier = ref.read(selectedPeriodProvider.notifier);
    final today = LocalDate.today(ref.watch(clockProvider));

    void done() => Navigator.pop(context);

    Future<void> pickCustom() async {
      final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: today.toDateTime(),
        initialDateRange: DateTimeRange(
          start: period.start.toDateTime(),
          end: LocalDate.min(period.end, today).toDateTime(),
        ),
      );
      if (range == null || !context.mounted) return;
      notifier.setCustom(
        LocalDate.fromDateTime(range.start),
        LocalDate.fromDateTime(range.end),
      );
      done();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenPadding,
        0,
        Dimens.screenPadding,
        Dimens.screenPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.period_title, style: theme.textTheme.titleLarge),
          const SizedBox(height: Dimens.space4),
          SegmentedButton<PeriodKind>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: PeriodKind.week,
                label: Text(l10n.period_week),
              ),
              ButtonSegment(
                value: PeriodKind.month,
                label: Text(l10n.period_month),
              ),
              ButtonSegment(
                value: PeriodKind.year,
                label: Text(l10n.period_year),
              ),
              ButtonSegment(
                value: PeriodKind.custom,
                label: Text(l10n.period_custom),
              ),
            ],
            selected: {_kind},
            onSelectionChanged: (s) {
              final kind = s.single;
              setState(() => _kind = kind);
              if (kind == PeriodKind.week) {
                notifier.setKind(kind);
                done();
              } else if (kind == PeriodKind.custom) {
                pickCustom();
              }
            },
          ),
          const SizedBox(height: Dimens.space4),
          if (_kind == PeriodKind.month || _kind == PeriodKind.year)
            Row(
              children: [
                IconButton(
                  tooltip: l10n.period_previous,
                  icon: const Icon(Symbols.chevron_left_rounded),
                  onPressed: () => setState(() => _year--),
                ),
                Expanded(
                  child: Text(
                    '$_year',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: l10n.period_next,
                  icon: const Icon(Symbols.chevron_right_rounded),
                  onPressed: _year < today.year
                      ? () => setState(() => _year++)
                      : null,
                ),
              ],
            ),
          if (_kind == PeriodKind.month)
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.6,
              children: [
                for (var month = 1; month <= 12; month++)
                  () {
                    final date = LocalDate(_year, month, 1);
                    final future =
                        _year > today.year ||
                        (_year == today.year && month > today.month);
                    final selected =
                        period.kind == PeriodKind.month &&
                        period.contains(LocalDate(_year, month, 15));
                    return Padding(
                      padding: const EdgeInsets.all(Dimens.space1),
                      child: selected
                          ? FilledButton(
                              onPressed: done,
                              child: Text(AppDateFormat.monthShort(date)),
                            )
                          : TextButton(
                              onPressed: future
                                  ? null
                                  : () {
                                      notifier.setMonth(_year, month);
                                      done();
                                    },
                              child: Text(AppDateFormat.monthShort(date)),
                            ),
                    );
                  }(),
              ],
            ),
          if (_kind == PeriodKind.year)
            FilledButton.tonal(
              onPressed: () {
                notifier.setYear(_year);
                done();
              },
              child: Text(l10n.period_show_year('$_year')),
            ),
          if (_kind == PeriodKind.custom)
            FilledButton.tonal(
              onPressed: pickCustom,
              child: Text(l10n.period_choose_dates),
            ),
          const SizedBox(height: Dimens.space2),
          TextButton(
            onPressed: () {
              notifier.reset();
              done();
            },
            child: Text(l10n.period_current),
          ),
        ],
      ),
    );
  }
}
