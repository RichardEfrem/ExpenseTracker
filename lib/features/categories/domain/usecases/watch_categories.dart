import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchCategories {
  const WatchCategories(this._repository);

  final CategoryRepository _repository;

  Stream<Either<Failure, List<Category>>> call({
    CategoryType? type,
    bool includeArchived = false,
  }) => _repository.watchAll(type: type, includeArchived: includeArchived);
}
