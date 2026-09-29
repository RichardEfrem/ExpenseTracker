import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/pagination/paged_result.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/activity/data/datasources/activity_local_datasource.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/day_group.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/filter_summary.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/activity/domain/repositories/activity_repository.dart';
import 'package:expense_tracker/features/transactions/transaction/data/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:fpdart/fpdart.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  const ActivityRepositoryImpl(this._dataSource);

  final ActivityLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, PagedResult<DayGroup>>> watchPage(
    TransactionFilter filter,
    Period cursor,
  ) => guardStream(
    _dataSource.watchRange(filter, cursor.start, cursor.end).asyncMap((
      rows,
    ) async {
      // Rows arrive newest first, so each day's rows are contiguous.
      final days = <(DayGroup, List<TransactionView>)>[];
      for (final (:row, :dayNet) in rows) {
        final view = row.toView();
        final date = view.transaction.date;
        if (days.isEmpty || days.last.$1.date != date) {
          days.add((
            DayGroup(date: date, net: dayNet, items: const []),
            [view],
          ));
        } else {
          days.last.$2.add(view);
        }
      }
      final groups = [
        for (final (day, items) in days)
          DayGroup(date: day.date, net: day.net, items: items),
      ];
      return PagedResult(
        items: groups,
        hasMore: await _dataSource.existsBefore(filter, cursor.start),
      );
    }),
  );

  @override
  Stream<Either<Failure, FilterSummary>> watchSummary(
    TransactionFilter filter,
  ) => guardStream(
    _dataSource
        .watchSummary(filter)
        .map(
          (s) => FilterSummary(
            count: s.count,
            income: s.income,
            expense: s.expense,
          ),
        )
        .distinct(),
  );
}
