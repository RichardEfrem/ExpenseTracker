// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dailyRepository)
final dailyRepositoryProvider = DailyRepositoryProvider._();

final class DailyRepositoryProvider
    extends
        $FunctionalProvider<DailyRepository, DailyRepository, DailyRepository>
    with $Provider<DailyRepository> {
  DailyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyRepositoryHash();

  @$internal
  @override
  $ProviderElement<DailyRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DailyRepository create(Ref ref) {
    return dailyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DailyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DailyRepository>(value),
    );
  }
}

String _$dailyRepositoryHash() => r'1534eaae7543d3897c5ca2a9368ccb7f377225b0';

@ProviderFor(watchDailySpending)
final watchDailySpendingProvider = WatchDailySpendingProvider._();

final class WatchDailySpendingProvider
    extends
        $FunctionalProvider<
          WatchDailySpending,
          WatchDailySpending,
          WatchDailySpending
        >
    with $Provider<WatchDailySpending> {
  WatchDailySpendingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchDailySpendingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchDailySpendingHash();

  @$internal
  @override
  $ProviderElement<WatchDailySpending> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchDailySpending create(Ref ref) {
    return watchDailySpending(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchDailySpending value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchDailySpending>(value),
    );
  }
}

String _$watchDailySpendingHash() =>
    r'3b706f129828c2314dae364573723830fd58212c';
