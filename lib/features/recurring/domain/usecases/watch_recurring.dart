import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchRecurringRules {
  const WatchRecurringRules(this._repository);

  final RecurringRepository _repository;

  Stream<Either<Failure, List<RuleView>>> call() => _repository.watchRules();
}

class WatchPendingOccurrences {
  const WatchPendingOccurrences(this._repository);

  final RecurringRepository _repository;

  Stream<Either<Failure, List<PendingView>>> call() =>
      _repository.watchPending();
}

class GetRecurringRule {
  const GetRecurringRule(this._repository);

  final RecurringRepository _repository;

  Future<Either<Failure, RecurringRule>> call(String id) =>
      _repository.getRule(id);
}
