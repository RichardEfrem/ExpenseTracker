import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/transactions/transaction/data/datasources/transaction_local_datasource.dart';
import 'package:expense_tracker/features/transactions/transaction/data/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/repositories/transaction_repository.dart';
import 'package:fpdart/fpdart.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this._dataSource, this._clock, this._ids);

  final TransactionLocalDataSource _dataSource;
  final Clock _clock;
  final IdGenerator _ids;

  int get _now => _clock.now().toUtc().millisecondsSinceEpoch;

  static String _categoryKey(TransactionType type) =>
      'last_used.${type.name}.category';
  static String _accountKey(TransactionType type) =>
      'last_used.${type.name}.account';

  static Never _notFound() => throw const FailureException(Failure.notFound());

  @override
  Future<Either<Failure, Transaction>> add(TransactionInput input) => guard(
    () => _dataSource.transaction(() async {
      final id = _ids.newId();
      final now = _now;
      await _dataSource.insert({
        ...input.toJson(),
        'id': id,
        'created_at': now,
        'updated_at': now,
      });
      await _writeLastUsed(
        input.type,
        LastUsed(categoryId: input.categoryId, accountId: input.accountId),
      );
      return (await _dataSource.findById(id))!.toEntity();
    }),
  );

  @override
  Future<Either<Failure, Unit>> update(String id, TransactionInput input) =>
      guard(
        () => _dataSource.transaction(() async {
          final changed = await _dataSource.update(id, {
            ...input.toJson(),
            'updated_at': _now,
          });
          if (changed == 0) _notFound();
          return unit;
        }),
      );

  @override
  Future<Either<Failure, Transaction>> delete(String id) => guard(
    () => _dataSource.transaction(() async {
      final row = await _dataSource.findById(id);
      if (row == null) _notFound();
      await _dataSource.delete(id);
      return row.toEntity();
    }),
  );

  @override
  Future<Either<Failure, Unit>> restore(Transaction transaction) =>
      guard(() async {
        await _dataSource.insert(transaction.toRowJson());
        return unit;
      });

  @override
  Future<Either<Failure, Transaction>> get(String id) => guard(() async {
    final row = await _dataSource.findById(id);
    if (row == null) _notFound();
    return row.toEntity();
  });

  @override
  Stream<Either<Failure, TransactionView?>> watch(String id) =>
      guardStream(_dataSource.watchJoined(id).map((row) => row?.toView()));

  @override
  Stream<Either<Failure, List<TransactionView>>> watchRecent(int limit) =>
      guardStream(
        _dataSource
            .watchRecent(limit)
            .map((rows) => [for (final row in rows) row.toView()]),
      );

  @override
  Future<Either<Failure, LastUsed>> getLastUsed(TransactionType type) => guard(
    () async => LastUsed(
      categoryId: await _dataSource.getSetting(_categoryKey(type)),
      accountId: await _dataSource.getSetting(_accountKey(type)),
    ),
  );

  @override
  Future<Either<Failure, Unit>> setLastUsed(
    TransactionType type,
    LastUsed value,
  ) => guard(
    () => _dataSource.transaction(() async {
      await _writeLastUsed(type, value);
      return unit;
    }),
  );

  Future<void> _writeLastUsed(TransactionType type, LastUsed value) async {
    await _dataSource.putSetting(_categoryKey(type), value.categoryId);
    await _dataSource.putSetting(_accountKey(type), value.accountId);
  }
}
