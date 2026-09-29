import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

enum AppThemeMode { system, light, dark }

/// User preferences (PRD §4.6).
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppThemeMode.system) AppThemeMode themeMode,

    /// Day of month a "month" starts on, 1–31 (e.g. 25 for payday).
    @Default(1) int monthStartDay,

    /// First day of the week, 1 (Monday) … 7 (Sunday).
    @Default(DateTime.monday) int weekStart,

    /// Derive the accent from the wallpaper (money colors never change).
    @Default(false) bool dynamicColor,
    DateTime? lastBackupAt,
  }) = _AppSettings;
}
