import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Creates (or queues) every occurrence due since the last run, up to
/// today. Runs on app open; there is no background service (PRD REC-02).
class GenerateDueOccurrences {
  const GenerateDueOccurrences(this._repository, this._clock);

  final RecurringRepository _repository;
  final Clock _clock;

  Future<Either<Failure, GenerationResult>> call() async {
    final today = LocalDate.today(_clock);
    final rules = await _repository.allRules();
    return rules.match((failure) async => Left(failure), (rules) {
      final plans = <RuleGeneration>[];
      for (final rule in rules) {
        final end = rule.endDate;
        final through = end == null ? today : LocalDate.min(today, end);
        if (rule.lastGeneratedDate != null &&
            rule.lastGeneratedDate! >= through) {
          continue;
        }
        plans.add(
          RuleGeneration(
            rule: rule,
            dates: rule.schedule.between(rule.lastGeneratedDate, through),
            through: through,
          ),
        );
      }
      return _repository.saveGeneration(plans);
    });
  }
}
