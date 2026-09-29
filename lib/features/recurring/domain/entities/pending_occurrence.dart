import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/accounts_domain.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_occurrence.freezed.dart';

/// A due occurrence waiting for confirm or skip (PRD REC-03).
@freezed
abstract class PendingOccurrence with _$PendingOccurrence {
  const factory PendingOccurrence({
    required String id,
    required String ruleId,
    required LocalDate date,
    required DateTime createdAt,
  }) = _PendingOccurrence;
}

/// A rule with the category and accounts it refers to, for display.
@Freezed(copyWith: false)
abstract class RuleView with _$RuleView {
  const factory RuleView({
    required RecurringRule rule,
    Category? category,
    required Account account,
    Account? toAccount,
  }) = _RuleView;
}

@Freezed(copyWith: false)
abstract class PendingView with _$PendingView {
  const factory PendingView({
    required PendingOccurrence pending,
    required RuleView rule,
  }) = _PendingView;
}

/// What one run of generation plans for a rule.
@Freezed(copyWith: false)
abstract class RuleGeneration with _$RuleGeneration {
  const factory RuleGeneration({
    required RecurringRule rule,

    /// Due dates to create (auto) or queue (pending).
    required List<LocalDate> dates,

    /// The rule's new last-generated date.
    required LocalDate through,
  }) = _RuleGeneration;
}

@freezed
abstract class GenerationResult with _$GenerationResult {
  const factory GenerationResult({
    @Default(0) int created,
    @Default(0) int pending,
  }) = _GenerationResult;
}
