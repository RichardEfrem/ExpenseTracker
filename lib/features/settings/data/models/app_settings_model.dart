import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';

/// Keys of the preferences this module owns in the `settings` table.
abstract final class SettingsKeys {
  static const themeMode = 'theme_mode';
  static const monthStartDay = 'month_start_day';
  static const weekStart = 'week_start';
  static const dynamicColor = 'dynamic_color';
  static const lastBackupAt = 'last_backup_at';
}

/// Reads [AppSettings] from key/value rows. Unknown or malformed values fall
/// back to defaults, so a bad row never breaks the app.
AppSettings appSettingsFromRows(Map<String, String> rows) {
  const defaults = AppSettings();
  int? intOf(String key) => int.tryParse(rows[key] ?? '');
  final monthStartDay = intOf(SettingsKeys.monthStartDay);
  final weekStart = intOf(SettingsKeys.weekStart);
  final backupMs = intOf(SettingsKeys.lastBackupAt);
  return AppSettings(
    themeMode: AppThemeMode.values.firstWhere(
      (m) => m.name == rows[SettingsKeys.themeMode],
      orElse: () => defaults.themeMode,
    ),
    monthStartDay:
        monthStartDay != null && monthStartDay >= 1 && monthStartDay <= 31
        ? monthStartDay
        : defaults.monthStartDay,
    weekStart: weekStart != null && weekStart >= 1 && weekStart <= 7
        ? weekStart
        : defaults.weekStart,
    dynamicColor: rows[SettingsKeys.dynamicColor] == 'true',
    lastBackupAt: backupMs == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(backupMs, isUtc: true),
  );
}
