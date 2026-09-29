import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/features/recurring/data/datasources/recurring_local_datasource.dart';
import 'package:expense_tracker/features/recurring/data/models/recurring_rule_model.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:fpdart/fpdart.dart';

class RecurringRepositoryImpl implements RecurringRepository {
  const RecurringRepositoryImpl(this._dataSource, this._clock, this._ids);

  final RecurringLocalDataSource _dataSource;
  final Clock _clock;
  final IdGenerator _ids;

  int get _now => _clock.now().toUtc().millisecondsSinceEpoch;

  static Never _notFound() => throw const FailureException(Failure.notFound());

  @override
  Stream<Either<Failure, List<RuleView>>> watchRules() => guardStream(
    _dataSource.watchRules().map(
      (rows) => [for (final row in rows) row.toView()]
        // Soonest next date first; ended rules last.
        ..sort((a, b) {
          final (x, y) = (a.rule.nextDate, b.rule.nextDate);
          if (x == null || y == null) {
            return x == null ? (y == null ? 0 : 1) : -1;
          }
          return x.compareTo(y);
        }),
    ),
  );

  @override
  Stream<Either<Failure, List<PendingView>>> watchPending() => guardStream(
    _dataSource.watchPending().map(
      (rows) => [
        for (final row in rows)
          PendingView(pending: row.pending.toEntity(), rule: row.rule.toView()),
      ],
    ),
  );

  @override
  Future<Either<Failure, RecurringRule>> getRule(String id) => guard(() async {
    final row = await _dataSource.findRule(id);
    if (row == null) _notFound();
    return row.toEntity();
  });

  @override
  Future<Either<Failure, List<RecurringRule>>> allRules() => guard(
    () async => [
      for (final row in await _dataSource.allRules()) row.toEntity(),
    ],
  );

  @override
  Future<Either<Failure, RecurringRule>> create(RecurringRuleInput input) =>
      guard(
        () => _dataSource.transaction(() async {
          final id = _ids.newId();
          final now = _now;
          await _dataSource.insertRule({
            ...input.toJson(),
            'id': id,
            'last_generated_date': null,
            'created_at': now,
            'updated_at': now,
          });
          return (await _dataSource.findRule(id))!.toEntity();
        }),
      );

  @override
  Future<Either<Failure, Unit>> update(String id, RecurringRuleInput input) =>
      guard(() async {
        final changed = await _dataSource.updateRule(id, {
          ...input.toJson(),
          'updated_at': _now,
        });
        if (changed == 0) _notFound();
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> delete(String id) => guard(
    () => _dataSource.transaction(() async {
      await _dataSource.unlinkTransactions(id, updatedAt: _now);
      await _dataSource.deletePendingOf(id);
      if (await _dataSource.deleteRule(id) == 0) _notFound();
      return unit;
    }),
  );

  @override
  Future<Either<Failure, GenerationResult>> saveGeneration(
    List<RuleGeneration> plans,
  ) => guard(
    () => _dataSource.transaction(() async {
      var created = 0;
      var pending = 0;
      for (final plan in plans) {
        final rule = plan.rule;
        final advanced = await _dataSource.advanceRule(
          rule.id,
          updatedAt: rule.updatedAt.millisecondsSinceEpoch,
          lastGenerated: rule.lastGeneratedDate?.toIso(),
          through: plan.through.toIso(),
        );
        if (advanced == 0) continue;
        final now = _now;
        for (final date in plan.dates) {
          if (rule.autoCreate) {
            await _dataSource.insertTransaction({
              ...rule.transactionJson(date),
              'id': _ids.newId(),
              'created_at': now,
              'updated_at': now,
            });
            created++;
          } else if (await _dataSource.insertPending({
            'id': _ids.newId(),
            'rule_id': rule.id,
            'date': date.toIso(),
            'created_at': now,
          })) {
            pending++;
          }
        }
      }
      return GenerationResult(created: created, pending: pending);
    }),
  );

  @override
  Future<Either<Failure, Unit>> confirmPending(String pendingId) => guard(
    () => _dataSource.transaction(() async {
      final pending = await _dataSource.findPending(pendingId);
      if (pending == null) _notFound();
      final rule = await _dataSource.findRule(pending.ruleId);
      if (rule == null) _notFound();
      final now = _now;
      await _dataSource.insertTransaction({
        ...rule.toEntity().transactionJson(pending.toEntity().date),
        'id': _ids.newId(),
        'created_at': now,
        'updated_at': now,
      });
      await _dataSource.deletePending(pendingId);
      return unit;
    }),
  );

  @override
  Future<Either<Failure, Unit>> skipPending(String pendingId) =>
      guard(() async {
        if (await _dataSource.deletePending(pendingId) == 0) _notFound();
        return unit;
      });
}
