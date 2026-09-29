import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/categories/data/datasources/category_local_datasource.dart';
import 'package:expense_tracker/features/categories/data/models/category_model.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._dataSource, this._clock, this._ids);

  final CategoryLocalDataSource _dataSource;
  final Clock _clock;
  final IdGenerator _ids;

  int get _now => _clock.now().toUtc().millisecondsSinceEpoch;

  static Never _fail(Failure failure) => throw FailureException(failure);

  @override
  Stream<Either<Failure, List<Category>>> watchAll({
    CategoryType? type,
    bool includeArchived = false,
  }) => guardStream(
    _dataSource
        .watchAll(type: type?.name, includeArchived: includeArchived)
        .map((rows) => [for (final row in rows) row.toEntity()]),
  );

  @override
  Stream<Either<Failure, Map<String, int>>> watchUsageCounts() =>
      guardStream(_dataSource.watchUsageCounts());

  @override
  Future<Either<Failure, Category>> create(CategoryInput input) => guard(
    () => _dataSource.transaction(() async {
      final id = _ids.newId();
      final now = _now;
      await _dataSource.insert({
        ...input.toJson(),
        'id': id,
        'is_archived': false,
        'sort_order': await _dataSource.nextSortOrder(input.type.name),
        'created_at': now,
        'updated_at': now,
      });
      return (await _dataSource.findById(id))!.toEntity();
    }),
  );

  @override
  Future<Either<Failure, Unit>> update(String id, CategoryInput input) =>
      _write(id, {...input.toJson(forUpdate: true), 'updated_at': _now});

  @override
  Future<Either<Failure, Unit>> setArchived(
    String id, {
    required bool archived,
  }) => _write(id, {'is_archived': archived, 'updated_at': _now});

  @override
  Future<Either<Failure, Unit>> reorder(List<String> orderedIds) => guard(
    () => _dataSource.transaction(() async {
      final now = _now;
      for (final (index, id) in orderedIds.indexed) {
        await _dataSource.update(id, {'sort_order': index, 'updated_at': now});
      }
      return unit;
    }),
  );

  @override
  Future<Either<Failure, Unit>> delete(String id) => guard(
    () => _dataSource.transaction(() async {
      if (await _dataSource.countUsage(id) > 0) {
        _fail(const Failure.validation(ValidationReason.categoryInUse));
      }
      if (await _dataSource.delete(id) == 0) _fail(const Failure.notFound());
      return unit;
    }),
  );

  @override
  Future<Either<Failure, Unit>> merge({
    required String fromId,
    required String intoId,
  }) => guard(
    () => _dataSource.transaction(() async {
      final from = await _dataSource.findById(fromId);
      final into = await _dataSource.findById(intoId);
      if (from == null || into == null) _fail(const Failure.notFound());
      if (from.type != into.type) {
        _fail(const Failure.validation(ValidationReason.categoryTypeMismatch));
      }
      await _dataSource.reassignTransactions(fromId, intoId, updatedAt: _now);
      await _dataSource.delete(fromId);
      return unit;
    }),
  );

  Future<Either<Failure, Unit>> _write(String id, Map<String, Object?> json) =>
      guard(() async {
        if (await _dataSource.update(id, json) == 0) {
          _fail(const Failure.notFound());
        }
        return unit;
      });
}
