// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_breakdown_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryBreakdownRepository)
final categoryBreakdownRepositoryProvider =
    CategoryBreakdownRepositoryProvider._();

final class CategoryBreakdownRepositoryProvider
    extends
        $FunctionalProvider<
          CategoryBreakdownRepository,
          CategoryBreakdownRepository,
          CategoryBreakdownRepository
        >
    with $Provider<CategoryBreakdownRepository> {
  CategoryBreakdownRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryBreakdownRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryBreakdownRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoryBreakdownRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryBreakdownRepository create(Ref ref) {
    return categoryBreakdownRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryBreakdownRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryBreakdownRepository>(value),
    );
  }
}

String _$categoryBreakdownRepositoryHash() =>
    r'5c70d5614c24b2b9ee5654ea566791bef65751fc';

@ProviderFor(watchCategoryBreakdown)
final watchCategoryBreakdownProvider = WatchCategoryBreakdownProvider._();

final class WatchCategoryBreakdownProvider
    extends
        $FunctionalProvider<
          WatchCategoryBreakdown,
          WatchCategoryBreakdown,
          WatchCategoryBreakdown
        >
    with $Provider<WatchCategoryBreakdown> {
  WatchCategoryBreakdownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchCategoryBreakdownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchCategoryBreakdownHash();

  @$internal
  @override
  $ProviderElement<WatchCategoryBreakdown> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchCategoryBreakdown create(Ref ref) {
    return watchCategoryBreakdown(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchCategoryBreakdown value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchCategoryBreakdown>(value),
    );
  }
}

String _$watchCategoryBreakdownHash() =>
    r'4550a82f9b506e9bacd018df2eff818931e0b86d';
