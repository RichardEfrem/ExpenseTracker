import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:expense_tracker/features/settings/data/models/app_settings_model.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:expense_tracker/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._dataSource);

  final SettingsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, AppSettings>> watch() =>
      guardStream(_dataSource.watchAll().map(appSettingsFromRows).distinct());

  @override
  Future<Either<Failure, Unit>> setThemeMode(AppThemeMode mode) =>
      _put(SettingsKeys.themeMode, mode.name);

  @override
  Future<Either<Failure, Unit>> setMonthStartDay(int day) =>
      _put(SettingsKeys.monthStartDay, '$day');

  @override
  Future<Either<Failure, Unit>> setWeekStart(int weekday) =>
      _put(SettingsKeys.weekStart, '$weekday');

  @override
  Future<Either<Failure, Unit>> setLastBackupAt(DateTime at) =>
      _put(SettingsKeys.lastBackupAt, '${at.toUtc().millisecondsSinceEpoch}');

  Future<Either<Failure, Unit>> _put(String key, String value) =>
      guard(() async {
        await _dataSource.put(key, value);
        return unit;
      });
}
