import 'package:expense_tracker/features/reports/category_breakdown/data/repositories/category_breakdown_repository_impl.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/repositories/category_breakdown_repository.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/usecases/watch_category_breakdown.dart';
import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_breakdown_providers.g.dart';

@riverpod
CategoryBreakdownRepository categoryBreakdownRepository(Ref ref) =>
    CategoryBreakdownRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchCategoryBreakdown watchCategoryBreakdown(Ref ref) =>
    WatchCategoryBreakdown(ref.watch(categoryBreakdownRepositoryProvider));
