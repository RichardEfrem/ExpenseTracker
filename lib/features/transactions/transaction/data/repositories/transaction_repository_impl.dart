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
      final before = await _dataSource.balancesOf(_accountsOf(input));
      final id = _ids.newId();
      final now = _now;
      await _dataSource.insert({
        ...input.toJson(),
        'id': id,
        'created_at': now,
        'updated_at': now,
      });
      await _dataSource.setTags(id, input.tags, newId: _ids.newId, nowMs: now);
      await _ensureNotOverdrawn(before);
      await _writeLastUsed(
        input.type,
        LastUsed(categoryId: input.categoryId, accountId: input.accountId),
      );
      return _withTags((await _dataSource.findById(id))!.toEntity());
    }),
  );

  @override
  Future<Either<Failure, Unit>> update(String id, TransactionInput input) =>
      guard(
        () => _dataSource.transaction(() async {
          final old = await _dataSource.findById(id);
          if (old == null) _notFound();
          // The old accounts too: moving an income away lowers its account.
          final before = await _dataSource.balancesOf({
            ..._accountsOf(input),
            old.accountId,
            ?old.toAccountId,
          });
          final now = _now;
          await _dataSource.update(id, {...input.toJson(), 'updated_at': now});
          await _dataSource.setTags(
            id,
            input.tags,
            newId: _ids.newId,
            nowMs: now,
          );
          await _ensureNotOverdrawn(before);
          return unit;
        }),
      );

  static Set<String> _accountsOf(TransactionInput input) => {
    input.accountId,
    ?input.toAccountId,
  };

  /// Rejects a write that leaves an account below zero and lower than
  /// [before] (account id → balance before the write), so no one spends
  /// money an account doesn't hold. Throwing rolls the write back. An
  /// account already below zero may still go up.
  Future<void> _ensureNotOverdrawn(Map<String, int> before) async {
    final after = await _dataSource.balancesOf(before.keys.toSet());
    for (final MapEntry(key: id, value: balance) in after.entries) {
      if (balance < 0 && balance < before[id]!) {
        throw const FailureException(
          Failure.validation(ValidationReason.insufficientBalance),
        );
      }
    }
  }

  @override
  Future<Either<Failure, Transaction>> delete(String id) => guard(
    () => _dataSource.transaction(() async {
      final row = await _dataSource.findById(id);
      if (row == null) _notFound();
      // With its tags, so undo puts them back.
      final deleted = await _withTags(row.toEntity());
      await _dataSource.delete(id);
      await _dataSource.pruneTags();
      return deleted;
    }),
  );

  @override
  Future<Either<Failure, Unit>> restore(Transaction transaction) => guard(
    () => _dataSource.transaction(() async {
      await _dataSource.insert(transaction.toRowJson());
      await _dataSource.setTags(
        transaction.id,
        transaction.tags,
        newId: _ids.newId,
        nowMs: _now,
      );
      return unit;
    }),
  );

  @override
  Future<Either<Failure, Transaction>> get(String id) => guard(() async {
    final row = await _dataSource.findById(id);
    if (row == null) _notFound();
    return _withTags(row.toEntity());
  });

  Future<Transaction> _withTags(Transaction t) async =>
      t.copyWith(tags: await _dataSource.tagsOf(t.id));

  @override
  Stream<Either<Failure, TransactionView?>> watch(String id) => guardStream(
    _dataSource.watchJoined(id).asyncMap((row) async {
      if (row == null) return null;
      final view = row.toView();
      return TransactionView(
        transaction: await _withTags(view.transaction),
        category: view.category,
        account: view.account,
        toAccount: view.toAccount,
      );
    }),
  );

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
