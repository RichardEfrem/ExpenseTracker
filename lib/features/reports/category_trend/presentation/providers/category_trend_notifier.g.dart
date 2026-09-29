// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_trend_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryTrendNotifier)
final categoryTrendProvider = CategoryTrendNotifierFamily._();

final class CategoryTrendNotifierProvider
    extends $StreamNotifierProvider<CategoryTrendNotifier, CategoryTrend> {
  CategoryTrendNotifierProvider._({
    required CategoryTrendNotifierFamily super.from,
    required (ReportScope, int) super.argument,
  }) : super(
         retry: null,
         name: r'categoryTrendProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryTrendNotifierHash();

  @override
  String toString() {
    return r'categoryTrendProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CategoryTrendNotifier create() => CategoryTrendNotifier();

  @override
  bool operator ==(Object other) {
    return other is CategoryTrendNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryTrendNotifierHash() =>
    r'4784d0dde89816ac14393c30ffee0e10cf89e74d';

final class CategoryTrendNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CategoryTrendNotifier,
          AsyncValue<CategoryTrend>,
          CategoryTrend,
          Stream<CategoryTrend>,
          (ReportScope, int)
        > {
  CategoryTrendNotifierFamily._()
    : super(
        retry: null,
        name: r'categoryTrendProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategoryTrendNotifierProvider call(ReportScope scope, int monthCount) =>
      CategoryTrendNotifierProvider._(
        argument: (scope, monthCount),
        from: this,
      );

  @override
  String toString() => r'categoryTrendProvider';
}

abstract class _$CategoryTrendNotifier extends $StreamNotifier<CategoryTrend> {
  late final _$args = ref.$arg as (ReportScope, int);
  ReportScope get scope => _$args.$1;
  int get monthCount => _$args.$2;

  Stream<CategoryTrend> build(ReportScope scope, int monthCount);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CategoryTrend>, CategoryTrend>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CategoryTrend>, CategoryTrend>,
              AsyncValue<CategoryTrend>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
