// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_entry_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PIN entry on the lock screen (DESIGN §8.11): checks automatically once
/// the PIN's length is reached; keys are ignored during a wait.

@ProviderFor(LockScreenNotifier)
final lockScreenProvider = LockScreenNotifierProvider._();

/// PIN entry on the lock screen (DESIGN §8.11): checks automatically once
/// the PIN's length is reached; keys are ignored during a wait.
final class LockScreenNotifierProvider
    extends $NotifierProvider<LockScreenNotifier, LockScreenState> {
  /// PIN entry on the lock screen (DESIGN §8.11): checks automatically once
  /// the PIN's length is reached; keys are ignored during a wait.
  LockScreenNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lockScreenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lockScreenNotifierHash();

  @$internal
  @override
  LockScreenNotifier create() => LockScreenNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LockScreenState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LockScreenState>(value),
    );
  }
}

String _$lockScreenNotifierHash() =>
    r'15a1130fd2126609b0eb6ab79bd9ed63a57c6f81';

/// PIN entry on the lock screen (DESIGN §8.11): checks automatically once
/// the PIN's length is reached; keys are ignored during a wait.

abstract class _$LockScreenNotifier extends $Notifier<LockScreenState> {
  LockScreenState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LockScreenState, LockScreenState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LockScreenState, LockScreenState>,
              LockScreenState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).

@ProviderFor(PinSetupNotifier)
final pinSetupProvider = PinSetupNotifierFamily._();

/// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).
final class PinSetupNotifierProvider
    extends $NotifierProvider<PinSetupNotifier, PinSetupState> {
  /// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).
  PinSetupNotifierProvider._({
    required PinSetupNotifierFamily super.from,
    required PinSetupMode super.argument,
  }) : super(
         retry: null,
         name: r'pinSetupProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pinSetupNotifierHash();

  @override
  String toString() {
    return r'pinSetupProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PinSetupNotifier create() => PinSetupNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PinSetupState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PinSetupState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PinSetupNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pinSetupNotifierHash() => r'19c93b2e1adb7233b5cde4500fd2548902ad28de';

/// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).

final class PinSetupNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PinSetupNotifier,
          PinSetupState,
          PinSetupState,
          PinSetupState,
          PinSetupMode
        > {
  PinSetupNotifierFamily._()
    : super(
        retry: null,
        name: r'pinSetupProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).

  PinSetupNotifierProvider call(PinSetupMode mode) =>
      PinSetupNotifierProvider._(argument: mode, from: this);

  @override
  String toString() => r'pinSetupProvider';
}

/// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).

abstract class _$PinSetupNotifier extends $Notifier<PinSetupState> {
  late final _$args = ref.$arg as PinSetupMode;
  PinSetupMode get mode => _$args;

  PinSetupState build(PinSetupMode mode);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PinSetupState, PinSetupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PinSetupState, PinSetupState>,
              PinSetupState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
