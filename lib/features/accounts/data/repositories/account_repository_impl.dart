import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/accounts/data/datasources/account_local_datasource.dart';
import 'package:expense_tracker/features/accounts/data/models/account_model.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:expense_tracker/features/accounts/domain/repositories/account_repository.dart';
import 'package:fpdart/fpdart.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._dataSource, this._clock, this._ids);

  final AccountLocalDataSource _dataSource;
  final Clock _clock;
  final IdGenerator _ids;

  int get _now => _clock.now().toUtc().millisecondsSinceEpoch;

  static Never _fail(Failure failure) => throw FailureException(failure);

  @override
  Stream<Either<Failure, List<Account>>> watchAll({
    bool includeArchived = false,
  }) => guardStream(
    _dataSource
        .watchAll(includeArchived: includeArchived)
        .map((rows) => [for (final row in rows) row.toEntity()]),
  );

  @override
  Future<Either<Failure, Account>> getDefault() => guard(() async {
    final row = await _dataSource.firstActive();
    if (row == null) _fail(const Failure.notFound());
    return row.toEntity();
  });

  @override
  Future<Either<Failure, Account>> create(AccountInput input) => guard(
    () => _dataSource.transaction(() async {
      final id = _ids.newId();
      final now = _now;
      await _dataSource.insert({
        ...input.toJson(),
        'id': id,
        'is_archived': false,
        'sort_order': await _dataSource.nextSortOrder(),
        'created_at': now,
        'updated_at': now,
      });
      return (await _dataSource.findById(id))!.toEntity();
    }),
  );

  @override
  Future<Either<Failure, Unit>> update(String id, AccountInput input) =>
      guard(() async {
        final changed = await _dataSource.update(id, {
          ...input.toJson(),
          'updated_at': _now,
        });
        if (changed == 0) _fail(const Failure.notFound());
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> setArchived(
    String id, {
    required bool archived,
  }) => guard(
    () => _dataSource.transaction(() async {
      final row = await _dataSource.findById(id);
      if (row == null) _fail(const Failure.notFound());
      if (archived && !row.isArchived && await _dataSource.activeCount() <= 1) {
        _fail(const Failure.validation(ValidationReason.lastActiveAccount));
      }
      await _dataSource.update(id, {
        'is_archived': archived,
        'updated_at': _now,
      });
      return unit;
    }),
  );

  @override
  Future<Either<Failure, Unit>> delete(String id) => guard(
    () => _dataSource.transaction(() async {
      final row = await _dataSource.findById(id);
      if (row == null) _fail(const Failure.notFound());
      if (await _dataSource.countUsage(id) > 0) {
        _fail(const Failure.validation(ValidationReason.accountInUse));
      }
      if (!row.isArchived && await _dataSource.activeCount() <= 1) {
        _fail(const Failure.validation(ValidationReason.lastActiveAccount));
      }
      await _dataSource.delete(id);
      return unit;
    }),
  );

  @override
  Stream<Either<Failure, List<AccountBalance>>> watchBalances(LocalDate asOf) =>
      guardStream(
        _dataSource.watch(() async {
          final totals = await _dataSource.movementTotals(asOf);
          return [
            for (final row in await _dataSource.getAll(includeArchived: true))
              AccountBalance(
                account: row.toEntity(),
                balance: row.openingBalance + (totals[row.id] ?? 0),
              ),
          ];
        }),
      );

  @override
  Stream<Either<Failure, BalanceHistory>> watchHistory(List<LocalDate> dates) =>
      guardStream(
        _dataSource.watch(() async {
          final buckets = await _dataSource.movementBuckets(dates);
          final accounts = await _dataSource.getAll();
          return BalanceHistory(
            dates: dates,
            accounts: [for (final a in accounts) a.toEntity()],
            series: {
              for (final a in accounts)
                a.id: () {
                  var running = a.openingBalance;
                  return [
                    for (var i = 0; i < dates.length; i++)
                      running += buckets[a.id]?[i] ?? 0,
                  ];
                }(),
            },
          );
        }),
      );

  @override
  Future<Either<Failure, int>> adjustBalance(
    String accountId,
    int actualBalance, {
    required LocalDate date,
    required LocalTime time,
  }) => guard(
    () => _dataSource.transaction(() async {
      final row = await _dataSource.findById(accountId);
      if (row == null) _fail(const Failure.notFound());
      // Include everything recorded, even future-dated rows.
      final far = LocalDate(9999, 12, 31);
      final current =
          row.openingBalance +
          ((await _dataSource.movementTotals(far))[accountId] ?? 0);
      final delta = actualBalance - current;
      if (delta == 0) return 0;
      final now = _now;
      await _dataSource.insertTransaction({
        'id': _ids.newId(),
        'type': 'adjustment',
        'amount': delta.abs(),
        'account_id': accountId,
        // Set → money in; null → money out (amounts are always positive).
        'to_account_id': delta > 0 ? accountId : null,
        'category_id': null,
        'date': date.toIso(),
        'time': time.format(),
        'note': null,
        'created_at': now,
        'updated_at': now,
      });
      return delta;
    }),
  );
}
