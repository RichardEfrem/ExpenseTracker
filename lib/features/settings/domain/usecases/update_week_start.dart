import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/settings/domain/repositories/settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateWeekStart {
  const UpdateWeekStart(this._repository);

  final SettingsRepository _repository;

  /// [weekday] is 1 (Monday) … 7 (Sunday).
  Future<Either<Failure, Unit>> call(int weekday) async {
    if (weekday < DateTime.monday || weekday > DateTime.sunday) {
      return const Left(
        Failure.validation(ValidationReason.weekStartOutOfRange),
      );
    }
    return _repository.setWeekStart(weekday);
  }
}
