import 'package:expense_tracker/features/reports/category_trend/data/repositories/category_trend_repository_impl.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/repositories/category_trend_repository.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/usecases/watch_category_trend.dart';
import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_trend_providers.g.dart';

@riverpod
CategoryTrendRepository categoryTrendRepository(Ref ref) =>
    CategoryTrendRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchCategoryTrend watchCategoryTrend(Ref ref) =>
    WatchCategoryTrend(ref.watch(categoryTrendRepositoryProvider));
