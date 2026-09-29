import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/uuid_provider.dart';
import 'package:expense_tracker/features/recurring/data/datasources/recurring_local_datasource.dart';
import 'package:expense_tracker/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:expense_tracker/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:expense_tracker/features/recurring/domain/usecases/generate_due_occurrences.dart';
import 'package:expense_tracker/features/recurring/domain/usecases/resolve_pending.dart';
import 'package:expense_tracker/features/recurring/domain/usecases/save_recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/usecases/watch_recurring.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_providers.g.dart';

@riverpod
RecurringLocalDataSource recurringLocalDataSource(Ref ref) =>
    RecurringLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
RecurringRepository recurringRepository(Ref ref) => RecurringRepositoryImpl(
  ref.watch(recurringLocalDataSourceProvider),
  ref.watch(clockProvider),
  ref.watch(idGeneratorProvider),
);

@riverpod
WatchRecurringRules watchRecurringRules(Ref ref) =>
    WatchRecurringRules(ref.watch(recurringRepositoryProvider));

@riverpod
WatchPendingOccurrences watchPendingOccurrences(Ref ref) =>
    WatchPendingOccurrences(ref.watch(recurringRepositoryProvider));

@riverpod
GetRecurringRule getRecurringRule(Ref ref) =>
    GetRecurringRule(ref.watch(recurringRepositoryProvider));

@riverpod
CreateRecurringRule createRecurringRule(Ref ref) =>
    CreateRecurringRule(ref.watch(recurringRepositoryProvider));

@riverpod
UpdateRecurringRule updateRecurringRule(Ref ref) =>
    UpdateRecurringRule(ref.watch(recurringRepositoryProvider));

@riverpod
DeleteRecurringRule deleteRecurringRule(Ref ref) =>
    DeleteRecurringRule(ref.watch(recurringRepositoryProvider));

@riverpod
GenerateDueOccurrences generateDueOccurrences(Ref ref) =>
    GenerateDueOccurrences(
      ref.watch(recurringRepositoryProvider),
      ref.watch(clockProvider),
    );

@riverpod
ConfirmPending confirmPending(Ref ref) =>
    ConfirmPending(ref.watch(recurringRepositoryProvider));

@riverpod
SkipPending skipPending(Ref ref) =>
    SkipPending(ref.watch(recurringRepositoryProvider));
