import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:expense_tracker/features/settings/presentation/providers/settings_notifier.dart';
import 'package:expense_tracker/features/settings/presentation/widgets/preference_labels.dart';
import 'package:expense_tracker/features/settings/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Accounts, categories, data and preferences (DESIGN §8.6). Items not built
/// yet are shown disabled.
class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final version = ref.watch(appVersionProvider).value;

    Widget item(
      IconData icon,
      String title, {
      String? path,
      String? subtitle,
    }) => ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: path == null
          ? Text(l10n.more_coming_soon)
          : subtitle == null
          ? null
          : Text(subtitle),
      enabled: path != null,
      onTap: path == null ? null : () => context.push(path),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nav_more)),
      body: ListView(
        children: [
          SectionHeader(l10n.more_section_money),
          item(
            Symbols.account_balance_wallet_rounded,
            l10n.more_accounts,
            path: AppPaths.accounts,
          ),
          item(
            Symbols.category_rounded,
            l10n.more_categories,
            path: AppPaths.categories,
          ),
          item(
            Symbols.repeat_rounded,
            l10n.more_recurring,
            path: AppPaths.recurring,
          ),
          SectionHeader(l10n.more_section_data),
          item(Symbols.backup_rounded, l10n.more_backup, path: AppPaths.backup),
          item(Symbols.table_view_rounded, l10n.more_export_csv),
          SectionHeader(l10n.more_section_preferences),
          item(
            Symbols.payments_rounded,
            l10n.more_currency,
            path: AppPaths.preferences,
            subtitle: MoneyFormat.full(1250000),
          ),
          item(
            Symbols.calendar_month_rounded,
            l10n.more_month_start_day,
            path: AppPaths.preferences,
            subtitle: l10n.pref_month_start_value(settings.monthStartDay),
          ),
          item(
            Symbols.date_range_rounded,
            l10n.more_week_start,
            path: AppPaths.preferences,
            subtitle: weekdayLabel(l10n, settings.weekStart),
          ),
          item(
            Symbols.contrast_rounded,
            l10n.more_theme,
            path: AppPaths.preferences,
            subtitle: themeModeLabel(l10n, settings.themeMode),
          ),
          item(Symbols.lock_rounded, l10n.more_app_lock),
          SectionHeader(l10n.more_section_about),
          ListTile(
            leading: const Icon(Symbols.info_rounded),
            title: Text(l10n.more_version),
            subtitle: version == null ? null : Text(version),
          ),
          item(
            Symbols.delete_forever_rounded,
            l10n.more_erase_all,
            path: AppPaths.backup,
          ),
        ],
      ),
    );
  }
}
