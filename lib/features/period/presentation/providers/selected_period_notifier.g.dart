// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_period_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The period Home, Activity and Reports show (DESIGN §7.1). Deliberately
/// app-lifetime: one choice shared by all three screens.

@ProviderFor(SelectedPeriodNotifier)
final selectedPeriodProvider = SelectedPeriodNotifierProvider._();

/// The period Home, Activity and Reports show (DESIGN §7.1). Deliberately
/// app-lifetime: one choice shared by all three screens.
final class SelectedPeriodNotifierProvider
    extends $NotifierProvider<SelectedPeriodNotifier, Period> {
  /// The period Home, Activity and Reports show (DESIGN §7.1). Deliberately
  /// app-lifetime: one choice shared by all three screens.
  SelectedPeriodNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPeriodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPeriodNotifierHash();

  @$internal
  @override
  SelectedPeriodNotifier create() => SelectedPeriodNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Period value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Period>(value),
    );
  }
}

String _$selectedPeriodNotifierHash() =>
    r'227ffce4be858e12932ca29c71a1ced6598dd98c';

/// The period Home, Activity and Reports show (DESIGN §7.1). Deliberately
/// app-lifetime: one choice shared by all three screens.

abstract class _$SelectedPeriodNotifier extends $Notifier<Period> {
  Period build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Period, Period>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Period, Period>,
              Period,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
