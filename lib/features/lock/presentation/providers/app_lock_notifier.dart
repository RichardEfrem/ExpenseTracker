import 'dart:async';

import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/lock/data/lock_providers.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lock_notifier.freezed.dart';
part 'app_lock_notifier.g.dart';

enum LockStatus { locked, unlocked }

@freezed
abstract class AppLockState with _$AppLockState {
  const factory AppLockState({
    required LockSettings settings,
    required LockStatus status,
  }) = _AppLockState;

  const AppLockState._();

  bool get isLocked => status == LockStatus.locked;
}

/// Whether the app is locked (PRD US-13, §6.4). Locked at start while a
/// PIN is set, and again on return after the timeout. App-lifetime.
@Riverpod(keepAlive: true)
class AppLockNotifier extends _$AppLockNotifier {
  /// When the app went to the background while unlocked.
  DateTime? _hiddenAt;

  DateTime _now() => ref.read(clockProvider).now();

  @override
  Future<AppLockState> build() async {
    // Unreadable storage opens the app rather than locking the user out of
    // their own data for good.
    final settings = (await ref.read(
      getLockSettingsProvider,
    )()).getOrElse((_) => const LockSettings());
    if (settings.enabled) _applySecureWindow(enabled: true);
    return AppLockState(
      settings: settings,
      status: settings.enabled ? LockStatus.locked : LockStatus.unlocked,
    );
  }

  void _set(AppLockState Function(AppLockState) change) {
    if (state.value case final current?) state = AsyncData(change(current));
  }

  void _applySecureWindow({required bool enabled}) =>
      unawaited(ref.read(applySecureWindowProvider)(lockEnabled: enabled));

  /// The app left the screen.
  void onHidden() {
    if (state.value?.status == LockStatus.unlocked) _hiddenAt = _now();
  }

  /// The app is back: lock if it was away at least the timeout.
  void onResumed() {
    final hiddenAt = _hiddenAt;
    _hiddenAt = null;
    final current = state.value;
    if (hiddenAt == null || current == null) return;
    if (current.settings.locksAfter(_now().difference(hiddenAt))) {
      _set((s) => s.copyWith(status: LockStatus.locked));
    }
  }

  /// Checks a PIN; unlocks on success.
  Future<Either<Failure, UnlockResult>> unlockWithPin(String pin) async {
    final result = await ref.read(verifyPinProvider)(pin);
    if (!ref.mounted) return result;
    if (result case Right(value: UnlockSuccess())) {
      _set((s) => s.copyWith(status: LockStatus.unlocked));
    }
    return result;
  }

  /// Shows the OS prompt when biometric unlock is on; true once unlocked.
  Future<bool> unlockWithBiometric(String reason) async {
    if (state.value?.settings.biometric != true) return false;
    final ok = (await ref.read(authenticateBiometricProvider)(
      reason,
    )).getOrElse((_) => false);
    if (ok && ref.mounted) {
      _set((s) => s.copyWith(status: LockStatus.unlocked));
    }
    return ok;
  }

  /// Checks a PIN without changing the lock (e.g. before disabling).
  Future<Either<Failure, UnlockResult>> checkPin(String pin) =>
      ref.read(verifyPinProvider)(pin);

  Future<void> _reload() async {
    final settings = await ref.read(getLockSettingsProvider)();
    if (!ref.mounted) return;
    settings.match(
      (_) {},
      (settings) => _set((s) => s.copyWith(settings: settings)),
    );
  }

  /// Sets a new PIN (turning the lock on if it was off), still unlocked.
  Future<Failure?> setPin(String pin) async {
    final failure = (await ref.read(setPinProvider)(pin)).failureOrNull;
    if (failure != null) return failure;
    _applySecureWindow(enabled: true);
    await _reload();
    return null;
  }

  Future<Failure?> disable() async {
    final failure = (await ref.read(disableLockProvider)()).failureOrNull;
    if (failure != null) return failure;
    _applySecureWindow(enabled: false);
    _set(
      (_) => const AppLockState(
        settings: LockSettings(),
        status: LockStatus.unlocked,
      ),
    );
    return null;
  }

  Future<Failure?> setBiometric({required bool enabled}) async {
    final failure = (await ref.read(setBiometricUnlockProvider)(
      enabled: enabled,
    )).failureOrNull;
    await _reload();
    return failure;
  }

  Future<Failure?> setTimeout(LockTimeout timeout) async {
    final failure = (await ref.read(setLockTimeoutProvider)(
      timeout,
    )).failureOrNull;
    await _reload();
    return failure;
  }
}

/// Whether the device has fingerprint/face enrolled.
@riverpod
class BiometricAvailabilityNotifier extends _$BiometricAvailabilityNotifier {
  @override
  Future<bool> build() async => (await ref.read(
    checkBiometricAvailableProvider,
  )()).getOrElse((_) => false);
}

/// Where the router sends [uri] for [status] (PRD §6.4): anywhere to the
/// lock screen while locked, remembering where to return; the lock screen
/// back there once unlocked. Null (no redirect) while the state loads.
String? lockRedirect(LockStatus? status, Uri uri) {
  final atLock = uri.path == AppPaths.lock;
  return switch (status) {
    LockStatus.locked when !atLock => AppPaths.lockReturningTo(uri.toString()),
    LockStatus.unlocked when atLock => _returnTarget(uri),
    _ => null,
  };
}

/// The `from` location, when it's an in-app path other than the lock.
String _returnTarget(Uri uri) {
  final from = uri.queryParameters['from'];
  if (from == null || !from.startsWith('/')) return AppPaths.home;
  return Uri.parse(from).path == AppPaths.lock ? AppPaths.home : from;
}
