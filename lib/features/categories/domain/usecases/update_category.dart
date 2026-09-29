import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateCategory {
  const UpdateCategory(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, Unit>> call(String id, CategoryInput input) =>
      input.validated().match(
        (reason) async => Left(Failure.validation(reason)),
        (valid) => _repository.update(id, valid),
      );
}
