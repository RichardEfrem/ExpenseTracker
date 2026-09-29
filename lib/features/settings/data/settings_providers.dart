import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:expense_tracker/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:expense_tracker/features/settings/domain/repositories/settings_repository.dart';
import 'package:expense_tracker/features/settings/domain/usecases/update_month_start_day.dart';
import 'package:expense_tracker/features/settings/domain/usecases/update_theme_mode.dart';
import 'package:expense_tracker/features/settings/domain/usecases/update_week_start.dart';
import 'package:expense_tracker/features/settings/domain/usecases/watch_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_providers.g.dart';

@riverpod
SettingsLocalDataSource settingsLocalDataSource(Ref ref) =>
    SettingsLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepositoryImpl(ref.watch(settingsLocalDataSourceProvider));

@riverpod
WatchSettings watchSettings(Ref ref) =>
    WatchSettings(ref.watch(settingsRepositoryProvider));

@riverpod
UpdateThemeMode updateThemeMode(Ref ref) =>
    UpdateThemeMode(ref.watch(settingsRepositoryProvider));

@riverpod
UpdateMonthStartDay updateMonthStartDay(Ref ref) =>
    UpdateMonthStartDay(ref.watch(settingsRepositoryProvider));

@riverpod
UpdateWeekStart updateWeekStart(Ref ref) =>
    UpdateWeekStart(ref.watch(settingsRepositoryProvider));
