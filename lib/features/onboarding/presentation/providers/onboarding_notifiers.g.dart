// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the router sends everything to onboarding. False until [check]
/// runs, which `main.dart` does before the first frame; so tests and data
/// erased mid-session never jump into onboarding. Deliberately app-lifetime.

@ProviderFor(OnboardingGate)
final onboardingGateProvider = OnboardingGateProvider._();

/// Whether the router sends everything to onboarding. False until [check]
/// runs, which `main.dart` does before the first frame; so tests and data
/// erased mid-session never jump into onboarding. Deliberately app-lifetime.
final class OnboardingGateProvider
    extends $NotifierProvider<OnboardingGate, bool> {
  /// Whether the router sends everything to onboarding. False until [check]
  /// runs, which `main.dart` does before the first frame; so tests and data
  /// erased mid-session never jump into onboarding. Deliberately app-lifetime.
  OnboardingGateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingGateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingGateHash();

  @$internal
  @override
  OnboardingGate create() => OnboardingGate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingGateHash() => r'd92bacf71fd8936d21a7badd4caba316975ee107';

/// Whether the router sends everything to onboarding. False until [check]
/// runs, which `main.dart` does before the first frame; so tests and data
/// erased mid-session never jump into onboarding. Deliberately app-lifetime.

abstract class _$OnboardingGate extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The three onboarding pages' choices (DESIGN §8.12).

@ProviderFor(OnboardingFormNotifier)
final onboardingFormProvider = OnboardingFormNotifierProvider._();

/// The three onboarding pages' choices (DESIGN §8.12).
final class OnboardingFormNotifierProvider
    extends $NotifierProvider<OnboardingFormNotifier, OnboardingForm> {
  /// The three onboarding pages' choices (DESIGN §8.12).
  OnboardingFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingFormNotifierHash();

  @$internal
  @override
  OnboardingFormNotifier create() => OnboardingFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingForm value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingForm>(value),
    );
  }
}

String _$onboardingFormNotifierHash() =>
    r'de31deb07bcb07ed772be0578ae3e19e88e6b2b5';

/// The three onboarding pages' choices (DESIGN §8.12).

abstract class _$OnboardingFormNotifier extends $Notifier<OnboardingForm> {
  OnboardingForm build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OnboardingForm, OnboardingForm>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OnboardingForm, OnboardingForm>,
              OnboardingForm,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
