// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(compareRepository)
final compareRepositoryProvider = CompareRepositoryProvider._();

final class CompareRepositoryProvider
    extends
        $FunctionalProvider<
          CompareRepository,
          CompareRepository,
          CompareRepository
        >
    with $Provider<CompareRepository> {
  CompareRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'compareRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$compareRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompareRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompareRepository create(Ref ref) {
    return compareRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompareRepository>(value),
    );
  }
}

String _$compareRepositoryHash() => r'81bdf772f6a85501d52606a4a5ea2ef63330213e';

@ProviderFor(watchComparison)
final watchComparisonProvider = WatchComparisonProvider._();

final class WatchComparisonProvider
    extends
        $FunctionalProvider<WatchComparison, WatchComparison, WatchComparison>
    with $Provider<WatchComparison> {
  WatchComparisonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchComparisonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchComparisonHash();

  @$internal
  @override
  $ProviderElement<WatchComparison> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchComparison create(Ref ref) {
    return watchComparison(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchComparison value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchComparison>(value),
    );
  }
}

String _$watchComparisonHash() => r'41c4126201d20f5403b8eefd960bc028f9cef8ce';
