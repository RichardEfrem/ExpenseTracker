import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/uuid_provider.dart';
import 'package:expense_tracker/features/categories/data/datasources/category_local_datasource.dart';
import 'package:expense_tracker/features/categories/data/repositories/category_repository_impl.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:expense_tracker/features/categories/domain/usecases/archive_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/create_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/delete_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/merge_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/reorder_categories.dart';
import 'package:expense_tracker/features/categories/domain/usecases/unarchive_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/update_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/watch_categories.dart';
import 'package:expense_tracker/features/categories/domain/usecases/watch_category_usage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_providers.g.dart';

@riverpod
CategoryLocalDataSource categoryLocalDataSource(Ref ref) =>
    CategoryLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
CategoryRepository categoryRepository(Ref ref) => CategoryRepositoryImpl(
  ref.watch(categoryLocalDataSourceProvider),
  ref.watch(clockProvider),
  ref.watch(idGeneratorProvider),
);

@riverpod
WatchCategories watchCategories(Ref ref) =>
    WatchCategories(ref.watch(categoryRepositoryProvider));

@riverpod
WatchCategoryUsage watchCategoryUsage(Ref ref) =>
    WatchCategoryUsage(ref.watch(categoryRepositoryProvider));

@riverpod
CreateCategory createCategory(Ref ref) =>
    CreateCategory(ref.watch(categoryRepositoryProvider));

@riverpod
UpdateCategory updateCategory(Ref ref) =>
    UpdateCategory(ref.watch(categoryRepositoryProvider));

@riverpod
ReorderCategories reorderCategories(Ref ref) =>
    ReorderCategories(ref.watch(categoryRepositoryProvider));

@riverpod
ArchiveCategory archiveCategory(Ref ref) =>
    ArchiveCategory(ref.watch(categoryRepositoryProvider));

@riverpod
UnarchiveCategory unarchiveCategory(Ref ref) =>
    UnarchiveCategory(ref.watch(categoryRepositoryProvider));

@riverpod
DeleteCategory deleteCategory(Ref ref) =>
    DeleteCategory(ref.watch(categoryRepositoryProvider));

@riverpod
MergeCategory mergeCategory(Ref ref) =>
    MergeCategory(ref.watch(categoryRepositoryProvider));
