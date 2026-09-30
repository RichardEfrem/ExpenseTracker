import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:expense_tracker/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:expense_tracker/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:expense_tracker/features/onboarding/domain/usecases/onboarding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_providers.g.dart';

@riverpod
OnboardingLocalDataSource onboardingLocalDataSource(Ref ref) =>
    OnboardingLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
OnboardingRepository onboardingRepository(Ref ref) => OnboardingRepositoryImpl(
  ref.watch(onboardingLocalDataSourceProvider),
  ref.watch(clockProvider),
);

@riverpod
GetOnboardingPending getOnboardingPending(Ref ref) =>
    GetOnboardingPending(ref.watch(onboardingRepositoryProvider));

@riverpod
CompleteOnboarding completeOnboarding(Ref ref) =>
    CompleteOnboarding(ref.watch(onboardingRepositoryProvider));

@riverpod
SkipOnboarding skipOnboarding(Ref ref) =>
    SkipOnboarding(ref.watch(onboardingRepositoryProvider));
