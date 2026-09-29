// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_trend_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryTrendRepository)
final categoryTrendRepositoryProvider = CategoryTrendRepositoryProvider._();

final class CategoryTrendRepositoryProvider
    extends
        $FunctionalProvider<
          CategoryTrendRepository,
          CategoryTrendRepository,
          CategoryTrendRepository
        >
    with $Provider<CategoryTrendRepository> {
  CategoryTrendRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryTrendRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryTrendRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoryTrendRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryTrendRepository create(Ref ref) {
    return categoryTrendRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryTrendRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryTrendRepository>(value),
    );
  }
}

String _$categoryTrendRepositoryHash() =>
    r'a1c3ebd13ece1bd6e539ce55ac9f8e00f7b484e4';

@ProviderFor(watchCategoryTrend)
final watchCategoryTrendProvider = WatchCategoryTrendProvider._();

final class WatchCategoryTrendProvider
    extends
        $FunctionalProvider<
          WatchCategoryTrend,
          WatchCategoryTrend,
          WatchCategoryTrend
        >
    with $Provider<WatchCategoryTrend> {
  WatchCategoryTrendProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchCategoryTrendProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchCategoryTrendHash();

  @$internal
  @override
  $ProviderElement<WatchCategoryTrend> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchCategoryTrend create(Ref ref) {
    return watchCategoryTrend(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchCategoryTrend value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchCategoryTrend>(value),
    );
  }
}

String _$watchCategoryTrendHash() =>
    r'416d1c8e943004f0300e9ce8ad46fccda6baadd2';
