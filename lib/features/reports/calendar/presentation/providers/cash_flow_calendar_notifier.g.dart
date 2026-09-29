// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_flow_calendar_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CashFlowCalendarNotifier)
final cashFlowCalendarProvider = CashFlowCalendarNotifierFamily._();

final class CashFlowCalendarNotifierProvider
    extends
        $StreamNotifierProvider<CashFlowCalendarNotifier, CashFlowCalendar> {
  CashFlowCalendarNotifierProvider._({
    required CashFlowCalendarNotifierFamily super.from,
    required ReportScope super.argument,
  }) : super(
         retry: null,
         name: r'cashFlowCalendarProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cashFlowCalendarNotifierHash();

  @override
  String toString() {
    return r'cashFlowCalendarProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CashFlowCalendarNotifier create() => CashFlowCalendarNotifier();

  @override
  bool operator ==(Object other) {
    return other is CashFlowCalendarNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cashFlowCalendarNotifierHash() =>
    r'd53ba2fb2369a54ee55d0006145f3bb7e1ed95d3';

final class CashFlowCalendarNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CashFlowCalendarNotifier,
          AsyncValue<CashFlowCalendar>,
          CashFlowCalendar,
          Stream<CashFlowCalendar>,
          ReportScope
        > {
  CashFlowCalendarNotifierFamily._()
    : super(
        retry: null,
        name: r'cashFlowCalendarProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CashFlowCalendarNotifierProvider call(ReportScope scope) =>
      CashFlowCalendarNotifierProvider._(argument: scope, from: this);

  @override
  String toString() => r'cashFlowCalendarProvider';
}

abstract class _$CashFlowCalendarNotifier
    extends $StreamNotifier<CashFlowCalendar> {
  late final _$args = ref.$arg as ReportScope;
  ReportScope get scope => _$args;

  Stream<CashFlowCalendar> build(ReportScope scope);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CashFlowCalendar>, CashFlowCalendar>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CashFlowCalendar>, CashFlowCalendar>,
              AsyncValue<CashFlowCalendar>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
