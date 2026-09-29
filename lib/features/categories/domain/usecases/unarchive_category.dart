import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class UnarchiveCategory {
  const UnarchiveCategory(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, Unit>> call(String id) =>
      _repository.setArchived(id, archived: false);
}
