import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:expense_tracker/features/settings/presentation/providers/settings_notifier.dart';
import 'package:expense_tracker/features/settings/presentation/widgets/preference_labels.dart';
import 'package:expense_tracker/features/settings/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Currency, month start day, week start and theme (PRD §4.6).
class PreferencesPage extends ConsumerWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final notifier = ref.read(settingsProvider.notifier);
    final today = LocalDate.today(ref.watch(clockProvider));
    final example = Period.monthContaining(
      today,
      startDay: settings.monthStartDay,
    );

    Future<void> apply(Future<Failure?> Function() write) async {
      final failure = await write();
      if (failure != null && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failureMessage(l10n, failure))));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pref_title)),
      body: ListView(
        children: [
          SectionHeader(l10n.pref_section_format),
          ListTile(
            leading: const Icon(Symbols.payments_rounded),
            title: Text(l10n.pref_currency_idr),
            subtitle: Text(MoneyFormat.full(1250000)),
          ),
          SectionHeader(l10n.pref_section_periods),
          ListTile(
            leading: const Icon(Symbols.calendar_month_rounded),
            title: Text(l10n.more_month_start_day),
            subtitle: Text(
              l10n.pref_month_start_example(
                settings.monthStartDay,
                AppDateFormat.period(example),
              ),
            ),
            onTap: () async {
              final day = await _pickMonthStartDay(
                context,
                settings.monthStartDay,
              );
              if (day != null) {
                await apply(() => notifier.setMonthStartDay(day));
              }
            },
          ),
          ListTile(
            leading: const Icon(Symbols.date_range_rounded),
            title: Text(l10n.more_week_start),
            subtitle: Text(weekdayLabel(l10n, settings.weekStart)),
            onTap: () async {
              final day = await _pickOne<int>(
                context,
                title: l10n.more_week_start,
                values: weekStartChoices,
                current: settings.weekStart,
                label: (d) => weekdayLabel(l10n, d),
              );
              if (day != null) await apply(() => notifier.setWeekStart(day));
            },
          ),
          SectionHeader(l10n.pref_section_appearance),
          ListTile(
            leading: const Icon(Symbols.contrast_rounded),
            title: Text(l10n.more_theme),
            subtitle: Text(themeModeLabel(l10n, settings.themeMode)),
            onTap: () async {
              final mode = await _pickOne<AppThemeMode>(
                context,
                title: l10n.more_theme,
                values: AppThemeMode.values,
                current: settings.themeMode,
                label: (m) => themeModeLabel(l10n, m),
              );
              if (mode != null) await apply(() => notifier.setThemeMode(mode));
            },
          ),
        ],
      ),
    );
  }

  static Future<T?> _pickOne<T>(
    BuildContext context, {
    required String title,
    required List<T> values,
    required T current,
    required String Function(T) label,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(title),
        children: [
          RadioGroup<T>(
            groupValue: current,
            onChanged: (value) => Navigator.pop(context, value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final value in values)
                  RadioListTile<T>(value: value, title: Text(label(value))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Future<int?> _pickMonthStartDay(BuildContext context, int current) {
    final l10n = AppLocalizations.of(context);
    return showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.more_month_start_day),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            children: [
              for (var day = 1; day <= 31; day++)
                Semantics(
                  selected: day == current,
                  button: true,
                  label: l10n.pref_month_start_value(day),
                  excludeSemantics: true,
                  child: InkResponse(
                    onTap: () => Navigator.pop(context, day),
                    child: Center(
                      child: day == current
                          ? CircleAvatar(radius: 18, child: Text('$day'))
                          : Text('$day'),
                    ),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.common_cancel),
          ),
        ],
      ),
    );
  }
}
