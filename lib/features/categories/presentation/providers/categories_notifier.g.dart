// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Categories of one [type], active first, each group in sort order.

@ProviderFor(CategoriesNotifier)
final categoriesProvider = CategoriesNotifierFamily._();

/// Categories of one [type], active first, each group in sort order.
final class CategoriesNotifierProvider
    extends $StreamNotifierProvider<CategoriesNotifier, List<Category>> {
  /// Categories of one [type], active first, each group in sort order.
  CategoriesNotifierProvider._({
    required CategoriesNotifierFamily super.from,
    required (CategoryType, {bool includeArchived}) super.argument,
  }) : super(
         retry: null,
         name: r'categoriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoriesNotifierHash();

  @override
  String toString() {
    return r'categoriesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CategoriesNotifier create() => CategoriesNotifier();

  @override
  bool operator ==(Object other) {
    return other is CategoriesNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoriesNotifierHash() =>
    r'f6620187fbfc5893f3a6dc530bf372ccc924fb8a';

/// Categories of one [type], active first, each group in sort order.

final class CategoriesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CategoriesNotifier,
          AsyncValue<List<Category>>,
          List<Category>,
          Stream<List<Category>>,
          (CategoryType, {bool includeArchived})
        > {
  CategoriesNotifierFamily._()
    : super(
        retry: null,
        name: r'categoriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Categories of one [type], active first, each group in sort order.

  CategoriesNotifierProvider call(
    CategoryType type, {
    bool includeArchived = false,
  }) => CategoriesNotifierProvider._(
    argument: (type, includeArchived: includeArchived),
    from: this,
  );

  @override
  String toString() => r'categoriesProvider';
}

/// Categories of one [type], active first, each group in sort order.

abstract class _$CategoriesNotifier extends $StreamNotifier<List<Category>> {
  late final _$args = ref.$arg as (CategoryType, {bool includeArchived});
  CategoryType get type => _$args.$1;
  bool get includeArchived => _$args.includeArchived;

  Stream<List<Category>> build(
    CategoryType type, {
    bool includeArchived = false,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Category>>, List<Category>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Category>>, List<Category>>,
              AsyncValue<List<Category>>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(_$args.$1, includeArchived: _$args.includeArchived),
    );
  }
}

/// Transaction count per category id.

@ProviderFor(CategoryUsageNotifier)
final categoryUsageProvider = CategoryUsageNotifierProvider._();

/// Transaction count per category id.
final class CategoryUsageNotifierProvider
    extends $StreamNotifierProvider<CategoryUsageNotifier, Map<String, int>> {
  /// Transaction count per category id.
  CategoryUsageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryUsageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryUsageNotifierHash();

  @$internal
  @override
  CategoryUsageNotifier create() => CategoryUsageNotifier();
}

String _$categoryUsageNotifierHash() =>
    r'6bb9624878d041c4e82ad98e373c04cea449dde2';

/// Transaction count per category id.

abstract class _$CategoryUsageNotifier
    extends $StreamNotifier<Map<String, int>> {
  Stream<Map<String, int>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, int>>, Map<String, int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<String, int>>, Map<String, int>>,
              AsyncValue<Map<String, int>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Category writes. Each returns its failure (or null) for the UI to show;
/// the watched lists update themselves.

@ProviderFor(CategoryActions)
final categoryActionsProvider = CategoryActionsProvider._();

/// Category writes. Each returns its failure (or null) for the UI to show;
/// the watched lists update themselves.
final class CategoryActionsProvider
    extends $NotifierProvider<CategoryActions, void> {
  /// Category writes. Each returns its failure (or null) for the UI to show;
  /// the watched lists update themselves.
  CategoryActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryActionsHash();

  @$internal
  @override
  CategoryActions create() => CategoryActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$categoryActionsHash() => r'4f78dad32d5e845be875d8e594d5aa4c745014c2';

/// Category writes. Each returns its failure (or null) for the UI to show;
/// the watched lists update themselves.

abstract class _$CategoryActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
