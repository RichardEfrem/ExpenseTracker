// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_spending_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DailySpendingNotifier)
final dailySpendingProvider = DailySpendingNotifierFamily._();

final class DailySpendingNotifierProvider
    extends $StreamNotifierProvider<DailySpendingNotifier, DailySpending> {
  DailySpendingNotifierProvider._({
    required DailySpendingNotifierFamily super.from,
    required ReportScope super.argument,
  }) : super(
         retry: null,
         name: r'dailySpendingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dailySpendingNotifierHash();

  @override
  String toString() {
    return r'dailySpendingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DailySpendingNotifier create() => DailySpendingNotifier();

  @override
  bool operator ==(Object other) {
    return other is DailySpendingNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dailySpendingNotifierHash() =>
    r'0079daff77e4c74b075fd50b3a940505e10c7638';

final class DailySpendingNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DailySpendingNotifier,
          AsyncValue<DailySpending>,
          DailySpending,
          Stream<DailySpending>,
          ReportScope
        > {
  DailySpendingNotifierFamily._()
    : super(
        retry: null,
        name: r'dailySpendingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DailySpendingNotifierProvider call(ReportScope scope) =>
      DailySpendingNotifierProvider._(argument: scope, from: this);

  @override
  String toString() => r'dailySpendingProvider';
}

abstract class _$DailySpendingNotifier extends $StreamNotifier<DailySpending> {
  late final _$args = ref.$arg as ReportScope;
  ReportScope get scope => _$args;

  Stream<DailySpending> build(ReportScope scope);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DailySpending>, DailySpending>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DailySpending>, DailySpending>,
              AsyncValue<DailySpending>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
