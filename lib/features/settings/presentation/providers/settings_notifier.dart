import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/settings/data/settings_providers.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_notifier.g.dart';

/// The user's preferences. Deliberately app-lifetime: theme and periods
/// depend on it everywhere.
@Riverpod(keepAlive: true)
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Stream<AppSettings> build() => ref.watch(watchSettingsProvider)().unwrap();

  Future<Failure?> setThemeMode(AppThemeMode mode) async =>
      (await ref.read(updateThemeModeProvider)(mode)).failureOrNull;

  Future<Failure?> setMonthStartDay(int day) async =>
      (await ref.read(updateMonthStartDayProvider)(day)).failureOrNull;

  Future<Failure?> setWeekStart(int weekday) async =>
      (await ref.read(updateWeekStartProvider)(weekday)).failureOrNull;
}

/// The theme to show; the default while settings load, so the first frame
/// never waits on the database.
@Riverpod(keepAlive: true)
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  @override
  AppThemeMode build() =>
      ref.watch(settingsProvider).value?.themeMode ??
      const AppSettings().themeMode;
}
