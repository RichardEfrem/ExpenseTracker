import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:fpdart/fpdart.dart';

class ConfirmPending {
  const ConfirmPending(this._repository);

  final RecurringRepository _repository;

  Future<Either<Failure, Unit>> call(String pendingId) =>
      _repository.confirmPending(pendingId);
}

class SkipPending {
  const SkipPending(this._repository);

  final RecurringRepository _repository;

  Future<Either<Failure, Unit>> call(String pendingId) =>
      _repository.skipPending(pendingId);
}
