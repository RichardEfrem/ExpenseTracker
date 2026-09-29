import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CategoryRepository {
  /// Categories of [type] (all types when null), active first then
  /// archived, each by sort order.
  Stream<Either<Failure, List<Category>>> watchAll({
    CategoryType? type,
    bool includeArchived = false,
  });

  /// Transaction count per category id (ids with none are absent).
  Stream<Either<Failure, Map<String, int>>> watchUsageCounts();

  /// Adds [input] at the end of its type's order.
  Future<Either<Failure, Category>> create(CategoryInput input);

  Future<Either<Failure, Unit>> update(String id, CategoryInput input);

  /// Sets sort order to the position of each id in [orderedIds].
  Future<Either<Failure, Unit>> reorder(List<String> orderedIds);

  Future<Either<Failure, Unit>> setArchived(
    String id, {
    required bool archived,
  });

  /// Fails with [ValidationReason.categoryInUse] if any transaction uses it.
  Future<Either<Failure, Unit>> delete(String id);

  /// Moves every transaction of [fromId] to [intoId], then deletes [fromId],
  /// in one DB transaction. Both must have the same type.
  Future<Either<Failure, Unit>> merge({
    required String fromId,
    required String intoId,
  });
}
