import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/data/categories_providers.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_notifier.g.dart';

/// Categories of one [type], active first, each group in sort order.
@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  Stream<List<Category>> build(
    CategoryType type, {
    bool includeArchived = false,
  }) => ref
      .watch(watchCategoriesProvider)(
        type: type,
        includeArchived: includeArchived,
      )
      .unwrap();
}

/// Transaction count per category id.
@riverpod
class CategoryUsageNotifier extends _$CategoryUsageNotifier {
  @override
  Stream<Map<String, int>> build() =>
      ref.watch(watchCategoryUsageProvider)().unwrap();
}

/// Category writes. Each returns its failure (or null) for the UI to show;
/// the watched lists update themselves.
@riverpod
class CategoryActions extends _$CategoryActions {
  @override
  void build() {}

  Future<Either<Failure, Category>> create(CategoryInput input) =>
      ref.read(createCategoryProvider)(input);

  Future<Failure?> update(String id, CategoryInput input) async =>
      (await ref.read(updateCategoryProvider)(id, input)).failureOrNull;

  Future<Failure?> reorder(List<String> orderedIds) async =>
      (await ref.read(reorderCategoriesProvider)(orderedIds)).failureOrNull;

  Future<Failure?> archive(String id) async =>
      (await ref.read(archiveCategoryProvider)(id)).failureOrNull;

  Future<Failure?> unarchive(String id) async =>
      (await ref.read(unarchiveCategoryProvider)(id)).failureOrNull;

  Future<Failure?> delete(String id) async =>
      (await ref.read(deleteCategoryProvider)(id)).failureOrNull;

  Future<Failure?> merge({
    required String fromId,
    required String intoId,
  }) async => (await ref.read(mergeCategoryProvider)(
    fromId: fromId,
    intoId: intoId,
  )).failureOrNull;
}
