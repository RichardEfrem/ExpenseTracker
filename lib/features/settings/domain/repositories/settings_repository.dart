import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class SettingsRepository {
  Stream<Either<Failure, AppSettings>> watch();

  Future<Either<Failure, Unit>> setThemeMode(AppThemeMode mode);

  Future<Either<Failure, Unit>> setMonthStartDay(int day);

  Future<Either<Failure, Unit>> setWeekStart(int weekday);

  Future<Either<Failure, Unit>> setLastBackupAt(DateTime at);
}
