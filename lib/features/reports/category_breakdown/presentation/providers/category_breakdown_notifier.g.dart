// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_breakdown_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryBreakdownNotifier)
final categoryBreakdownProvider = CategoryBreakdownNotifierFamily._();

final class CategoryBreakdownNotifierProvider
    extends
        $StreamNotifierProvider<CategoryBreakdownNotifier, CategoryBreakdown> {
  CategoryBreakdownNotifierProvider._({
    required CategoryBreakdownNotifierFamily super.from,
    required (ReportScope, CategoryType) super.argument,
  }) : super(
         retry: null,
         name: r'categoryBreakdownProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryBreakdownNotifierHash();

  @override
  String toString() {
    return r'categoryBreakdownProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CategoryBreakdownNotifier create() => CategoryBreakdownNotifier();

  @override
  bool operator ==(Object other) {
    return other is CategoryBreakdownNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryBreakdownNotifierHash() =>
    r'cdb7c740103b900f8f2db5060765db1db8616585';

final class CategoryBreakdownNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CategoryBreakdownNotifier,
          AsyncValue<CategoryBreakdown>,
          CategoryBreakdown,
          Stream<CategoryBreakdown>,
          (ReportScope, CategoryType)
        > {
  CategoryBreakdownNotifierFamily._()
    : super(
        retry: null,
        name: r'categoryBreakdownProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategoryBreakdownNotifierProvider call(
    ReportScope scope,
    CategoryType type,
  ) => CategoryBreakdownNotifierProvider._(argument: (scope, type), from: this);

  @override
  String toString() => r'categoryBreakdownProvider';
}

abstract class _$CategoryBreakdownNotifier
    extends $StreamNotifier<CategoryBreakdown> {
  late final _$args = ref.$arg as (ReportScope, CategoryType);
  ReportScope get scope => _$args.$1;
  CategoryType get type => _$args.$2;

  Stream<CategoryBreakdown> build(ReportScope scope, CategoryType type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CategoryBreakdown>, CategoryBreakdown>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CategoryBreakdown>, CategoryBreakdown>,
              AsyncValue<CategoryBreakdown>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
