import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:expense_tracker/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateThemeMode {
  const UpdateThemeMode(this._repository);

  final SettingsRepository _repository;

  Future<Either<Failure, Unit>> call(AppThemeMode mode) =>
      _repository.setThemeMode(mode);
}
