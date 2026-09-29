import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Merge A into B: reassign all of A's transactions to B, then delete A
/// (PRD CAT-06).
class MergeCategory {
  const MergeCategory(this._repository);

  final CategoryRepository _repository;

  Future<Either<Failure, Unit>> call({
    required String fromId,
    required String intoId,
  }) async {
    if (fromId == intoId) {
      return const Left(Failure.validation(ValidationReason.mergeIntoSelf));
    }
    return _repository.merge(fromId: fromId, intoId: intoId);
  }
}
