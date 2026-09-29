// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comparison_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ComparisonNotifier)
final comparisonProvider = ComparisonNotifierFamily._();

final class ComparisonNotifierProvider
    extends $StreamNotifierProvider<ComparisonNotifier, PeriodComparison> {
  ComparisonNotifierProvider._({
    required ComparisonNotifierFamily super.from,
    required (ReportScope, CategoryType) super.argument,
  }) : super(
         retry: null,
         name: r'comparisonProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$comparisonNotifierHash();

  @override
  String toString() {
    return r'comparisonProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ComparisonNotifier create() => ComparisonNotifier();

  @override
  bool operator ==(Object other) {
    return other is ComparisonNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$comparisonNotifierHash() =>
    r'7a6fe48dabb247ab36b0fe0f40298b6086aaa982';

final class ComparisonNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ComparisonNotifier,
          AsyncValue<PeriodComparison>,
          PeriodComparison,
          Stream<PeriodComparison>,
          (ReportScope, CategoryType)
        > {
  ComparisonNotifierFamily._()
    : super(
        retry: null,
        name: r'comparisonProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ComparisonNotifierProvider call(ReportScope scope, CategoryType type) =>
      ComparisonNotifierProvider._(argument: (scope, type), from: this);

  @override
  String toString() => r'comparisonProvider';
}

abstract class _$ComparisonNotifier extends $StreamNotifier<PeriodComparison> {
  late final _$args = ref.$arg as (ReportScope, CategoryType);
  ReportScope get scope => _$args.$1;
  CategoryType get type => _$args.$2;

  Stream<PeriodComparison> build(ReportScope scope, CategoryType type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PeriodComparison>, PeriodComparison>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PeriodComparison>, PeriodComparison>,
              AsyncValue<PeriodComparison>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
