// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the app is locked (PRD US-13, §6.4). Locked at start while a
/// PIN is set, and again on return after the timeout. App-lifetime.

@ProviderFor(AppLockNotifier)
final appLockProvider = AppLockNotifierProvider._();

/// Whether the app is locked (PRD US-13, §6.4). Locked at start while a
/// PIN is set, and again on return after the timeout. App-lifetime.
final class AppLockNotifierProvider
    extends $AsyncNotifierProvider<AppLockNotifier, AppLockState> {
  /// Whether the app is locked (PRD US-13, §6.4). Locked at start while a
  /// PIN is set, and again on return after the timeout. App-lifetime.
  AppLockNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockNotifierHash();

  @$internal
  @override
  AppLockNotifier create() => AppLockNotifier();
}

String _$appLockNotifierHash() => r'23cd8afc601f2f071c75b5a4d92cd2cc04aa62bb';

/// Whether the app is locked (PRD US-13, §6.4). Locked at start while a
/// PIN is set, and again on return after the timeout. App-lifetime.

abstract class _$AppLockNotifier extends $AsyncNotifier<AppLockState> {
  FutureOr<AppLockState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppLockState>, AppLockState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppLockState>, AppLockState>,
              AsyncValue<AppLockState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Whether the device has fingerprint/face enrolled.

@ProviderFor(BiometricAvailabilityNotifier)
final biometricAvailabilityProvider = BiometricAvailabilityNotifierProvider._();

/// Whether the device has fingerprint/face enrolled.
final class BiometricAvailabilityNotifierProvider
    extends $AsyncNotifierProvider<BiometricAvailabilityNotifier, bool> {
  /// Whether the device has fingerprint/face enrolled.
  BiometricAvailabilityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricAvailabilityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricAvailabilityNotifierHash();

  @$internal
  @override
  BiometricAvailabilityNotifier create() => BiometricAvailabilityNotifier();
}

String _$biometricAvailabilityNotifierHash() =>
    r'94fc675bfee0fcea5be7ee9739a8dd5dfc016f9a';

/// Whether the device has fingerprint/face enrolled.

abstract class _$BiometricAvailabilityNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
