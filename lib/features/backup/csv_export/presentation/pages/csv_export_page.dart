import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/usecases/export_csv.dart';
import 'package:expense_tracker/features/backup/csv_export/presentation/providers/csv_export_notifier.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Export CSV (DESIGN §8.10, PRD BAK-06): pick a date range, then share or
/// save the file.
class CsvExportPage extends ConsumerStatefulWidget {
  const CsvExportPage({super.key});

  @override
  ConsumerState<CsvExportPage> createState() => _CsvExportPageState();
}

class _CsvExportPageState extends ConsumerState<CsvExportPage> {
  var _busy = false;

  CsvExportFormNotifier get _form => ref.read(csvExportFormProvider.notifier);

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickCustom() async {
    final today = LocalDate.today(ref.read(clockProvider));
    final current = ref.read(csvExportFormProvider).custom;
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: today.addDays(365 * 5).toDateTime(),
      currentDate: today.toDateTime(),
      initialDateRange: current == null
          ? null
          : DateTimeRange(
              start: current.start.toDateTime(),
              end: current.end.toDateTime(),
            ),
    );
    if (picked == null) return;
    _form.setCustom(
      Period.custom(
        LocalDate.fromDateTime(picked.start),
        LocalDate.fromDateTime(picked.end),
      ),
    );
  }

  Future<void> _export(ExportTarget target) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final result = await _form.export(target);
      result.match((failure) => _toast(failureMessage(l10n, failure)), (
        result,
      ) {
        switch (result) {
          case CsvExported(:final count):
            _toast(l10n.csv_exported(count));
          case CsvExportEmpty():
            _toast(l10n.csv_empty);
          case CsvExportCancelled():
            break;
        }
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  static String _presetLabel(AppLocalizations l10n, CsvRangePreset preset) =>
      switch (preset) {
        CsvRangePreset.thisMonth => l10n.csv_this_month,
        CsvRangePreset.lastMonth => l10n.csv_last_month,
        CsvRangePreset.thisYear => l10n.csv_this_year,
        CsvRangePreset.lastYear => l10n.csv_last_year,
        CsvRangePreset.allTime => l10n.csv_all_time,
        CsvRangePreset.custom => l10n.csv_custom,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final form = ref.watch(csvExportFormProvider);
    // Rebuild when the month start day changes.
    ref.watch(settingsProvider.select((s) => s.value?.monthStartDay));
    final range = _form.currentRange();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.more_export_csv)),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          padding: const EdgeInsets.all(Dimens.screenPadding),
          children: [
            if (_busy) const LinearProgressIndicator(),
            Semantics(
              header: true,
              child: Text(l10n.csv_range, style: theme.textTheme.titleMedium),
            ),
            const SizedBox(height: Dimens.space2),
            Wrap(
              spacing: Dimens.space2,
              runSpacing: Dimens.space2,
              children: [
                for (final preset in CsvRangePreset.values)
                  ChoiceChip(
                    key: ValueKey('csv-${preset.name}'),
                    label: Text(_presetLabel(l10n, preset)),
                    selected: form.preset == preset,
                    onSelected: (_) => preset == CsvRangePreset.custom
                        ? _pickCustom()
                        : _form.setPreset(preset),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space4),
            Text(
              range == null
                  ? l10n.csv_range_all
                  : l10n.csv_range_between(
                      AppDateFormat.dayMonthYear(range.start),
                      AppDateFormat.dayMonthYear(range.end),
                    ),
              key: const ValueKey('csv-range'),
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: Dimens.space6),
            FilledButton.icon(
              key: const ValueKey('csv-share'),
              icon: const Icon(Symbols.ios_share_rounded),
              label: Text(l10n.csv_export),
              onPressed: () => _export(ExportTarget.share),
            ),
            const SizedBox(height: Dimens.space2),
            OutlinedButton.icon(
              key: const ValueKey('csv-save'),
              icon: const Icon(Symbols.save_rounded),
              label: Text(l10n.backup_save_to_device),
              onPressed: () => _export(ExportTarget.saveToDevice),
            ),
            const SizedBox(height: Dimens.space4),
            Text(
              l10n.csv_hint,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
