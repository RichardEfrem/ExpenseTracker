import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateMonthStartDay {
  const UpdateMonthStartDay(this._repository);

  final SettingsRepository _repository;

  Future<Either<Failure, Unit>> call(int day) async {
    if (day < 1 || day > 31) {
      return const Left(
        Failure.validation(ValidationReason.monthStartDayOutOfRange),
      );
    }
    return _repository.setMonthStartDay(day);
  }
}
