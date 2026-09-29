import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchCategoryUsage {
  const WatchCategoryUsage(this._repository);

  final CategoryRepository _repository;

  Stream<Either<Failure, Map<String, int>>> call() =>
      _repository.watchUsageCounts();
}
