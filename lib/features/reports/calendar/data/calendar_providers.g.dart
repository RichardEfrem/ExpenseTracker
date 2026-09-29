// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarRepository)
final calendarRepositoryProvider = CalendarRepositoryProvider._();

final class CalendarRepositoryProvider
    extends
        $FunctionalProvider<
          CalendarRepository,
          CalendarRepository,
          CalendarRepository
        >
    with $Provider<CalendarRepository> {
  CalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarRepository create(Ref ref) {
    return calendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarRepository>(value),
    );
  }
}

String _$calendarRepositoryHash() =>
    r'b179b7913bf47b8695b2d45377802cb11a1432d5';

@ProviderFor(watchCashFlowCalendar)
final watchCashFlowCalendarProvider = WatchCashFlowCalendarProvider._();

final class WatchCashFlowCalendarProvider
    extends
        $FunctionalProvider<
          WatchCashFlowCalendar,
          WatchCashFlowCalendar,
          WatchCashFlowCalendar
        >
    with $Provider<WatchCashFlowCalendar> {
  WatchCashFlowCalendarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchCashFlowCalendarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchCashFlowCalendarHash();

  @$internal
  @override
  $ProviderElement<WatchCashFlowCalendar> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchCashFlowCalendar create(Ref ref) {
    return watchCashFlowCalendar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchCashFlowCalendar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchCashFlowCalendar>(value),
    );
  }
}

String _$watchCashFlowCalendarHash() =>
    r'fd62e96fc41a75ccc6f1c5da8973e81bf5c152fa';
