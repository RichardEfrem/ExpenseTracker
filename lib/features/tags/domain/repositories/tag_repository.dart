import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/tags/domain/entities/tag.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TagRepository {
  /// Every tag with its usage, most used first, then by name. Tags are
  /// created by saving a transaction with them and disappear when no
  /// transaction uses them any more.
  Stream<Either<Failure, List<Tag>>> watchAll();
}
