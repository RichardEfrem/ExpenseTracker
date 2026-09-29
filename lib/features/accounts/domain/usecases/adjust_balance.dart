import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Reconciles an account with its real balance by recording an
/// adjustment, excluded from reports (PRD ACC-05).
class AdjustBalance {
  const AdjustBalance(this._repository, this._clock);

  final AccountRepository _repository;
  final Clock _clock;

  Future<Either<Failure, int>> call(String accountId, int actualBalance) {
    final now = _clock.now();
    return _repository.adjustBalance(
      accountId,
      actualBalance,
      date: LocalDate.fromDateTime(now),
      time: LocalTime.fromDateTime(now),
    );
  }
}
