import 'package:expense_tracker/features/reports/daily/data/repositories/daily_repository_impl.dart';
import 'package:expense_tracker/features/reports/daily/domain/repositories/daily_repository.dart';
import 'package:expense_tracker/features/reports/daily/domain/usecases/watch_daily_spending.dart';
import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'daily_providers.g.dart';

@riverpod
DailyRepository dailyRepository(Ref ref) =>
    DailyRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchDailySpending watchDailySpending(Ref ref) =>
    WatchDailySpending(ref.watch(dailyRepositoryProvider));
