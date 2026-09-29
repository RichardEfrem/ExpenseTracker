import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RecurringRepository {
  Stream<Either<Failure, List<RuleView>>> watchRules();

  /// Oldest first.
  Stream<Either<Failure, List<PendingView>>> watchPending();

  Future<Either<Failure, RecurringRule>> getRule(String id);

  Future<Either<Failure, List<RecurringRule>>> allRules();

  Future<Either<Failure, RecurringRule>> create(RecurringRuleInput input);

  /// Keeps the generation state, so past occurrences are not re-created.
  Future<Either<Failure, Unit>> update(String id, RecurringRuleInput input);

  /// Deletes the rule and its pending items; generated transactions stay.
  Future<Either<Failure, Unit>> delete(String id);

  /// Applies [plans] in one DB transaction. A plan whose rule changed since
  /// it was read (another run got there first) is skipped: idempotent.
  Future<Either<Failure, GenerationResult>> saveGeneration(
    List<RuleGeneration> plans,
  );

  /// Creates the transaction and removes the pending item, atomically.
  Future<Either<Failure, Unit>> confirmPending(String pendingId);

  Future<Either<Failure, Unit>> skipPending(String pendingId);
}
