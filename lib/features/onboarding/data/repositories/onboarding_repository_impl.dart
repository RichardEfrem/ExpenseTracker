import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';
import 'package:expense_tracker/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fpdart/fpdart.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._local, this._clock);

  final OnboardingLocalDataSource _local;
  final Clock _clock;

  @override
  Future<Either<Failure, bool>> isPending() => guard(_local.isPending);

  @override
  Future<Either<Failure, Unit>> complete(OnboardingInput input) =>
      guard(() async {
        final now = _clock.now().toUtc().millisecondsSinceEpoch;
        await _local.transaction(() async {
          for (final id in input.removedCategoryIds) {
            if (await _local.countCategoryUsage(id) == 0) {
              await _local.deleteCategory(id);
            } else {
              await _local.archiveCategory(id, now);
            }
          }
          final active = await _local.activeCategoryCounts();
          if ((active['expense'] ?? 0) == 0 || (active['income'] ?? 0) == 0) {
            // Throwing rolls the transaction back: nothing is removed.
            throw const FailureException(
              Failure.validation(ValidationReason.categoryRequired),
            );
          }
          if (input.openingCash != 0) {
            await _local.setDefaultAccountOpening(input.openingCash, now);
          }
          await _local.markDone();
        });
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> skip() => guard(() async {
    await _local.markDone();
    return unit;
  });
}
