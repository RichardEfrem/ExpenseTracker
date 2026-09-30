// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(onboardingLocalDataSource)
final onboardingLocalDataSourceProvider = OnboardingLocalDataSourceProvider._();

final class OnboardingLocalDataSourceProvider
    extends
        $FunctionalProvider<
          OnboardingLocalDataSource,
          OnboardingLocalDataSource,
          OnboardingLocalDataSource
        >
    with $Provider<OnboardingLocalDataSource> {
  OnboardingLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<OnboardingLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingLocalDataSource create(Ref ref) {
    return onboardingLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingLocalDataSource>(value),
    );
  }
}

String _$onboardingLocalDataSourceHash() =>
    r'6a18e83472da1496f7061d3aaace608159565e3b';

@ProviderFor(onboardingRepository)
final onboardingRepositoryProvider = OnboardingRepositoryProvider._();

final class OnboardingRepositoryProvider
    extends
        $FunctionalProvider<
          OnboardingRepository,
          OnboardingRepository,
          OnboardingRepository
        >
    with $Provider<OnboardingRepository> {
  OnboardingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingRepositoryHash();

  @$internal
  @override
  $ProviderElement<OnboardingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingRepository create(Ref ref) {
    return onboardingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingRepository>(value),
    );
  }
}

String _$onboardingRepositoryHash() =>
    r'335d03614f0b4f6197beb334006fe37c5069abb3';

@ProviderFor(getOnboardingPending)
final getOnboardingPendingProvider = GetOnboardingPendingProvider._();

final class GetOnboardingPendingProvider
    extends
        $FunctionalProvider<
          GetOnboardingPending,
          GetOnboardingPending,
          GetOnboardingPending
        >
    with $Provider<GetOnboardingPending> {
  GetOnboardingPendingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getOnboardingPendingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getOnboardingPendingHash();

  @$internal
  @override
  $ProviderElement<GetOnboardingPending> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetOnboardingPending create(Ref ref) {
    return getOnboardingPending(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetOnboardingPending value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetOnboardingPending>(value),
    );
  }
}

String _$getOnboardingPendingHash() =>
    r'f753a4c07a6986f0dbb16b45525ebfcdbf34b36a';

@ProviderFor(completeOnboarding)
final completeOnboardingProvider = CompleteOnboardingProvider._();

final class CompleteOnboardingProvider
    extends
        $FunctionalProvider<
          CompleteOnboarding,
          CompleteOnboarding,
          CompleteOnboarding
        >
    with $Provider<CompleteOnboarding> {
  CompleteOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeOnboardingHash();

  @$internal
  @override
  $ProviderElement<CompleteOnboarding> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompleteOnboarding create(Ref ref) {
    return completeOnboarding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompleteOnboarding value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompleteOnboarding>(value),
    );
  }
}

String _$completeOnboardingHash() =>
    r'fe7511e87f8af41163f3b103156a17dede162d3f';

@ProviderFor(skipOnboarding)
final skipOnboardingProvider = SkipOnboardingProvider._();

final class SkipOnboardingProvider
    extends $FunctionalProvider<SkipOnboarding, SkipOnboarding, SkipOnboarding>
    with $Provider<SkipOnboarding> {
  SkipOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skipOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skipOnboardingHash();

  @$internal
  @override
  $ProviderElement<SkipOnboarding> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SkipOnboarding create(Ref ref) {
    return skipOnboarding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SkipOnboarding value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SkipOnboarding>(value),
    );
  }
}

String _$skipOnboardingHash() => r'd484a1aa6d0e1c8da4be19495f349efa6b84e6b9';
