import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateRecurringRule {
  const CreateRecurringRule(this._repository);

  final RecurringRepository _repository;

  Future<Either<Failure, RecurringRule>> call(RecurringRuleInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        _repository.create,
      );
}

class UpdateRecurringRule {
  const UpdateRecurringRule(this._repository);

  final RecurringRepository _repository;

  Future<Either<Failure, Unit>> call(String id, RecurringRuleInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        (valid) => _repository.update(id, valid),
      );
}

class DeleteRecurringRule {
  const DeleteRecurringRule(this._repository);

  final RecurringRepository _repository;

  Future<Either<Failure, Unit>> call(String id) => _repository.delete(id);
}
