import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/statistics/data/statistics_providers.dart';
import 'package:expense_tracker/features/reports/statistics/domain/entities/period_statistics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistics_notifier.g.dart';

@riverpod
class StatisticsNotifier extends _$StatisticsNotifier {
  @override
  Stream<PeriodStatistics> build(ReportScope scope) => ref
      .watch(watchStatisticsProvider)(
        scope,
        LocalDate.today(ref.watch(clockProvider)),
      )
      .unwrap();

  /// The latest month with data before this scope, or null.
  Future<Period?> lastPeriodWithData() async => (await ref.read(
    findLastPeriodWithDataProvider,
  )(scope)).getOrElse((_) => null);
}
