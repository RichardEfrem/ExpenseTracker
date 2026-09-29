// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trends_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trendsRepository)
final trendsRepositoryProvider = TrendsRepositoryProvider._();

final class TrendsRepositoryProvider
    extends
        $FunctionalProvider<
          TrendsRepository,
          TrendsRepository,
          TrendsRepository
        >
    with $Provider<TrendsRepository> {
  TrendsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrendsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TrendsRepository create(Ref ref) {
    return trendsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrendsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrendsRepository>(value),
    );
  }
}

String _$trendsRepositoryHash() => r'e5d30640eedb6b3bed7e2834356fb439542af4af';

@ProviderFor(watchTrends)
final watchTrendsProvider = WatchTrendsProvider._();

final class WatchTrendsProvider
    extends $FunctionalProvider<WatchTrends, WatchTrends, WatchTrends>
    with $Provider<WatchTrends> {
  WatchTrendsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTrendsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTrendsHash();

  @$internal
  @override
  $ProviderElement<WatchTrends> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchTrends create(Ref ref) {
    return watchTrends(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTrends value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTrends>(value),
    );
  }
}

String _$watchTrendsHash() => r'45fce3d97f8cbe509e6e30bfb9025399cf24b00b';
