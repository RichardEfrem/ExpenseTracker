import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/tags/domain/entities/tag.dart';
import 'package:expense_tracker/features/tags/domain/repositories/tag_repository.dart';
import 'package:fpdart/fpdart.dart';

class WatchTags {
  const WatchTags(this._repository);

  final TagRepository _repository;

  Stream<Either<Failure, List<Tag>>> call() => _repository.watchAll();
}
