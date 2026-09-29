// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// One page of the Activity list: the days of [cursor] matching [filter].

@ProviderFor(ActivityPageNotifier)
final activityPageProvider = ActivityPageNotifierFamily._();

/// One page of the Activity list: the days of [cursor] matching [filter].
final class ActivityPageNotifierProvider
    extends
        $StreamNotifierProvider<ActivityPageNotifier, PagedResult<DayGroup>> {
  /// One page of the Activity list: the days of [cursor] matching [filter].
  ActivityPageNotifierProvider._({
    required ActivityPageNotifierFamily super.from,
    required (TransactionFilter, Period) super.argument,
  }) : super(
         retry: null,
         name: r'activityPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activityPageNotifierHash();

  @override
  String toString() {
    return r'activityPageProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ActivityPageNotifier create() => ActivityPageNotifier();

  @override
  bool operator ==(Object other) {
    return other is ActivityPageNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activityPageNotifierHash() =>
    r'5c66447e56d7deca4ccad916db139a475d14e426';

/// One page of the Activity list: the days of [cursor] matching [filter].

final class ActivityPageNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ActivityPageNotifier,
          AsyncValue<PagedResult<DayGroup>>,
          PagedResult<DayGroup>,
          Stream<PagedResult<DayGroup>>,
          (TransactionFilter, Period)
        > {
  ActivityPageNotifierFamily._()
    : super(
        retry: null,
        name: r'activityPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One page of the Activity list: the days of [cursor] matching [filter].

  ActivityPageNotifierProvider call(TransactionFilter filter, Period cursor) =>
      ActivityPageNotifierProvider._(argument: (filter, cursor), from: this);

  @override
  String toString() => r'activityPageProvider';
}

/// One page of the Activity list: the days of [cursor] matching [filter].

abstract class _$ActivityPageNotifier
    extends $StreamNotifier<PagedResult<DayGroup>> {
  late final _$args = ref.$arg as (TransactionFilter, Period);
  TransactionFilter get filter => _$args.$1;
  Period get cursor => _$args.$2;

  Stream<PagedResult<DayGroup>> build(TransactionFilter filter, Period cursor);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<PagedResult<DayGroup>>, PagedResult<DayGroup>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedResult<DayGroup>>,
                PagedResult<DayGroup>
              >,
              AsyncValue<PagedResult<DayGroup>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// Count and totals for [filter] (PRD SRCH-03).

@ProviderFor(FilterSummaryNotifier)
final filterSummaryProvider = FilterSummaryNotifierFamily._();

/// Count and totals for [filter] (PRD SRCH-03).
final class FilterSummaryNotifierProvider
    extends $StreamNotifierProvider<FilterSummaryNotifier, FilterSummary> {
  /// Count and totals for [filter] (PRD SRCH-03).
  FilterSummaryNotifierProvider._({
    required FilterSummaryNotifierFamily super.from,
    required TransactionFilter super.argument,
  }) : super(
         retry: null,
         name: r'filterSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filterSummaryNotifierHash();

  @override
  String toString() {
    return r'filterSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FilterSummaryNotifier create() => FilterSummaryNotifier();

  @override
  bool operator ==(Object other) {
    return other is FilterSummaryNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filterSummaryNotifierHash() =>
    r'716f746a7c52cde977915b7396c1c7480a80f968';

/// Count and totals for [filter] (PRD SRCH-03).

final class FilterSummaryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FilterSummaryNotifier,
          AsyncValue<FilterSummary>,
          FilterSummary,
          Stream<FilterSummary>,
          TransactionFilter
        > {
  FilterSummaryNotifierFamily._()
    : super(
        retry: null,
        name: r'filterSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Count and totals for [filter] (PRD SRCH-03).

  FilterSummaryNotifierProvider call(TransactionFilter filter) =>
      FilterSummaryNotifierProvider._(argument: filter, from: this);

  @override
  String toString() => r'filterSummaryProvider';
}

/// Count and totals for [filter] (PRD SRCH-03).

abstract class _$FilterSummaryNotifier extends $StreamNotifier<FilterSummary> {
  late final _$args = ref.$arg as TransactionFilter;
  TransactionFilter get filter => _$args;

  Stream<FilterSummary> build(TransactionFilter filter);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FilterSummary>, FilterSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FilterSummary>, FilterSummary>,
              AsyncValue<FilterSummary>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
