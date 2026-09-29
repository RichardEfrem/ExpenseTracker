// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trends_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrendsNotifier)
final trendsProvider = TrendsNotifierFamily._();

final class TrendsNotifierProvider
    extends $StreamNotifierProvider<TrendsNotifier, List<MonthTotals>> {
  TrendsNotifierProvider._({
    required TrendsNotifierFamily super.from,
    required (ReportScope, int) super.argument,
  }) : super(
         retry: null,
         name: r'trendsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trendsNotifierHash();

  @override
  String toString() {
    return r'trendsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  TrendsNotifier create() => TrendsNotifier();

  @override
  bool operator ==(Object other) {
    return other is TrendsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trendsNotifierHash() => r'1ec529a111ebdc76a0a0656802bb17b69c248ab8';

final class TrendsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TrendsNotifier,
          AsyncValue<List<MonthTotals>>,
          List<MonthTotals>,
          Stream<List<MonthTotals>>,
          (ReportScope, int)
        > {
  TrendsNotifierFamily._()
    : super(
        retry: null,
        name: r'trendsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TrendsNotifierProvider call(ReportScope scope, int monthCount) =>
      TrendsNotifierProvider._(argument: (scope, monthCount), from: this);

  @override
  String toString() => r'trendsProvider';
}

abstract class _$TrendsNotifier extends $StreamNotifier<List<MonthTotals>> {
  late final _$args = ref.$arg as (ReportScope, int);
  ReportScope get scope => _$args.$1;
  int get monthCount => _$args.$2;

  Stream<List<MonthTotals>> build(ReportScope scope, int monthCount);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MonthTotals>>, List<MonthTotals>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MonthTotals>>, List<MonthTotals>>,
              AsyncValue<List<MonthTotals>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
