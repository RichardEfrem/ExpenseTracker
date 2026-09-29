// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(statisticsRepository)
final statisticsRepositoryProvider = StatisticsRepositoryProvider._();

final class StatisticsRepositoryProvider
    extends
        $FunctionalProvider<
          StatisticsRepository,
          StatisticsRepository,
          StatisticsRepository
        >
    with $Provider<StatisticsRepository> {
  StatisticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StatisticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StatisticsRepository create(Ref ref) {
    return statisticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatisticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatisticsRepository>(value),
    );
  }
}

String _$statisticsRepositoryHash() =>
    r'4a0d993c9c6cb80d98f4949129f2b2b8b63da912';

@ProviderFor(watchStatistics)
final watchStatisticsProvider = WatchStatisticsProvider._();

final class WatchStatisticsProvider
    extends
        $FunctionalProvider<WatchStatistics, WatchStatistics, WatchStatistics>
    with $Provider<WatchStatistics> {
  WatchStatisticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchStatisticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchStatisticsHash();

  @$internal
  @override
  $ProviderElement<WatchStatistics> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchStatistics create(Ref ref) {
    return watchStatistics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchStatistics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchStatistics>(value),
    );
  }
}

String _$watchStatisticsHash() => r'70bb43cba9ac3ae34994c60bc0235582dd08bf5e';

@ProviderFor(findLastPeriodWithData)
final findLastPeriodWithDataProvider = FindLastPeriodWithDataProvider._();

final class FindLastPeriodWithDataProvider
    extends
        $FunctionalProvider<
          FindLastPeriodWithData,
          FindLastPeriodWithData,
          FindLastPeriodWithData
        >
    with $Provider<FindLastPeriodWithData> {
  FindLastPeriodWithDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'findLastPeriodWithDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$findLastPeriodWithDataHash();

  @$internal
  @override
  $ProviderElement<FindLastPeriodWithData> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FindLastPeriodWithData create(Ref ref) {
    return findLastPeriodWithData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FindLastPeriodWithData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FindLastPeriodWithData>(value),
    );
  }
}

String _$findLastPeriodWithDataHash() =>
    r'64569cf56814c3ea9e09e334c5d9861a79a9d016';
