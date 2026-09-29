import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class ReorderCategories {
  const ReorderCategories(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, Unit>> call(List<String> orderedIds) =>
      _repository.reorder(orderedIds);
}
