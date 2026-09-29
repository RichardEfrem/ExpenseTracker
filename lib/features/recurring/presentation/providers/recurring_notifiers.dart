import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/recurring/data/recurring_providers.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_notifiers.g.dart';

/// Every rule with its category and accounts, soonest next date first.
@riverpod
class RecurringRulesNotifier extends _$RecurringRulesNotifier {
  @override
  Stream<List<RuleView>> build() =>
      ref.watch(watchRecurringRulesProvider)().unwrap();
}

/// Due occurrences waiting for confirm or skip, oldest first (PRD REC-03).
@riverpod
class PendingOccurrencesNotifier extends _$PendingOccurrencesNotifier {
  @override
  Stream<List<PendingView>> build() =>
      ref.watch(watchPendingOccurrencesProvider)().unwrap();
}

/// Creates or queues every occurrence due up to today (PRD REC-02). Runs
/// when the app first listens (app open) and again on [run]: on resume and
/// after a rule is saved. Idempotent, so overlapping runs are harmless.
@Riverpod(keepAlive: true)
class RecurringGeneration extends _$RecurringGeneration {
  @override
  Future<GenerationResult> build() async =>
      (await ref.read(generateDueOccurrencesProvider)()).getOrThrow();

  Future<void> run() async {
    final result = await ref.read(generateDueOccurrencesProvider)();
    if (!ref.mounted) return;
    state = result.match(
      (failure) => AsyncError(failure, StackTrace.current),
      AsyncData.new,
    );
  }
}

/// Rule and pending writes; each returns its failure (or null) for the UI
/// to show. Watched lists update themselves.
@riverpod
class RecurringActions extends _$RecurringActions {
  @override
  void build() {}

  Future<Failure?> delete(String ruleId) async =>
      (await ref.read(deleteRecurringRuleProvider)(ruleId)).failureOrNull;

  Future<Failure?> confirm(String pendingId) async =>
      (await ref.read(confirmPendingProvider)(pendingId)).failureOrNull;

  Future<Failure?> skip(String pendingId) async =>
      (await ref.read(skipPendingProvider)(pendingId)).failureOrNull;
}
