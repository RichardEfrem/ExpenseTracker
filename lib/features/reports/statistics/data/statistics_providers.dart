import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:expense_tracker/features/reports/statistics/data/repositories/statistics_repository_impl.dart';
import 'package:expense_tracker/features/reports/statistics/domain/repositories/statistics_repository.dart';
import 'package:expense_tracker/features/reports/statistics/domain/usecases/find_last_period_with_data.dart';
import 'package:expense_tracker/features/reports/statistics/domain/usecases/watch_statistics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'statistics_providers.g.dart';

@riverpod
StatisticsRepository statisticsRepository(Ref ref) =>
    StatisticsRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchStatistics watchStatistics(Ref ref) =>
    WatchStatistics(ref.watch(statisticsRepositoryProvider));

@riverpod
FindLastPeriodWithData findLastPeriodWithData(Ref ref) =>
    FindLastPeriodWithData(ref.watch(statisticsRepositoryProvider));
