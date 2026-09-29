import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/pagination/paged_result.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/activity/data/activity_providers.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/day_group.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/filter_summary.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_notifiers.g.dart';

/// One page of the Activity list: the days of [cursor] matching [filter].
@riverpod
class ActivityPageNotifier extends _$ActivityPageNotifier {
  @override
  Stream<PagedResult<DayGroup>> build(
    TransactionFilter filter,
    Period cursor,
  ) => ref.watch(watchActivityPageProvider)(filter, cursor).unwrap();
}

/// Count and totals for [filter] (PRD SRCH-03).
@riverpod
class FilterSummaryNotifier extends _$FilterSummaryNotifier {
  @override
  Stream<FilterSummary> build(TransactionFilter filter) =>
      ref.watch(watchFilterSummaryProvider)(filter).unwrap();
}
