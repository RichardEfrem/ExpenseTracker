import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/tags/data/datasources/tag_local_datasource.dart';
import 'package:expense_tracker/features/tags/domain/entities/tag.dart';
import 'package:expense_tracker/features/tags/domain/repositories/tag_repository.dart';
import 'package:fpdart/fpdart.dart';

class TagRepositoryImpl implements TagRepository {
  const TagRepositoryImpl(this._local);

  final TagLocalDataSource _local;

  @override
  Stream<Either<Failure, List<Tag>>> watchAll() => guardStream(
    _local.watchAll().map(
      (rows) => [
        for (final r in rows)
          Tag(
            id: r.id,
            name: r.name,
            createdAt: DateTime.fromMillisecondsSinceEpoch(
              r.createdAt,
              isUtc: true,
            ),
            usage: r.usage,
          ),
      ],
    ),
  );
}
