// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StatisticsNotifier)
final statisticsProvider = StatisticsNotifierFamily._();

final class StatisticsNotifierProvider
    extends $StreamNotifierProvider<StatisticsNotifier, PeriodStatistics> {
  StatisticsNotifierProvider._({
    required StatisticsNotifierFamily super.from,
    required ReportScope super.argument,
  }) : super(
         retry: null,
         name: r'statisticsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$statisticsNotifierHash();

  @override
  String toString() {
    return r'statisticsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StatisticsNotifier create() => StatisticsNotifier();

  @override
  bool operator ==(Object other) {
    return other is StatisticsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$statisticsNotifierHash() =>
    r'5ef71a32fea4230f137869f07bc800568c5e7d93';

final class StatisticsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          StatisticsNotifier,
          AsyncValue<PeriodStatistics>,
          PeriodStatistics,
          Stream<PeriodStatistics>,
          ReportScope
        > {
  StatisticsNotifierFamily._()
    : super(
        retry: null,
        name: r'statisticsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StatisticsNotifierProvider call(ReportScope scope) =>
      StatisticsNotifierProvider._(argument: scope, from: this);

  @override
  String toString() => r'statisticsProvider';
}

abstract class _$StatisticsNotifier extends $StreamNotifier<PeriodStatistics> {
  late final _$args = ref.$arg as ReportScope;
  ReportScope get scope => _$args;

  Stream<PeriodStatistics> build(ReportScope scope);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PeriodStatistics>, PeriodStatistics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PeriodStatistics>, PeriodStatistics>,
              AsyncValue<PeriodStatistics>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
