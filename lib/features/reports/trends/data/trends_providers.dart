import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:expense_tracker/features/reports/trends/data/repositories/trends_repository_impl.dart';
import 'package:expense_tracker/features/reports/trends/domain/repositories/trends_repository.dart';
import 'package:expense_tracker/features/reports/trends/domain/usecases/watch_trends.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trends_providers.g.dart';

@riverpod
TrendsRepository trendsRepository(Ref ref) =>
    TrendsRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchTrends watchTrends(Ref ref) =>
    WatchTrends(ref.watch(trendsRepositoryProvider));
