import 'dart:async';

import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/lock/domain/entities/pin.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pin_entry_notifiers.freezed.dart';
part 'pin_entry_notifiers.g.dart';

/// [digits] after one keypad press, at most [max] long.
String applyPinKey(String digits, KeypadKey key, {int max = Pin.maxLength}) =>
    switch (key) {
      KeypadKey.backspace when digits.isNotEmpty => digits.substring(
        0,
        digits.length - 1,
      ),
      KeypadKey.clear => '',
      _ when key.digitValue != null && digits.length < max =>
        '$digits${key.digitValue}',
      _ => digits,
    };

@freezed
abstract class LockScreenState with _$LockScreenState {
  const factory LockScreenState({
    @Default('') String digits,

    /// The last rejected try (wrong or throttled), for the message.
    UnlockResult? rejected,
    Failure? failure,
    @Default(false) bool checking,
  }) = _LockScreenState;

  const LockScreenState._();

  bool get waiting => rejected is UnlockThrottled;
}

/// PIN entry on the lock screen (DESIGN §8.11): checks automatically once
/// the PIN's length is reached; keys are ignored during a wait.
@riverpod
class LockScreenNotifier extends _$LockScreenNotifier {
  Timer? _waitTimer;

  @override
  LockScreenState build() {
    ref.onDispose(() => _waitTimer?.cancel());
    return const LockScreenState();
  }

  Future<void> onKey(KeypadKey key) async {
    if (state.checking || state.waiting) return;
    final length = ref.read(appLockProvider).value?.settings.pinLength ?? 0;
    final digits = applyPinKey(state.digits, key, max: length);
    state = state.copyWith(digits: digits, failure: null);
    if (length == 0 || digits.length < length) return;

    state = state.copyWith(checking: true);
    final result = await ref
        .read(appLockProvider.notifier)
        .unlockWithPin(digits);
    if (!ref.mounted) return;
    result.match((failure) => state = LockScreenState(failure: failure), (
      outcome,
    ) {
      state = LockScreenState(
        rejected: outcome is UnlockSuccess ? null : outcome,
      );
      if (outcome case UnlockThrottled(:final retryAt)) _waitUntil(retryAt);
    });
  }

  void _waitUntil(DateTime retryAt) {
    _waitTimer?.cancel();
    final left = retryAt.difference(ref.read(clockProvider).now());
    _waitTimer = Timer(left.isNegative ? Duration.zero : left, () {
      if (ref.mounted) state = state.copyWith(rejected: null);
    });
  }
}

/// What the PIN screen in settings is for.
enum PinSetupMode { enable, change, disable }

enum PinSetupStep {
  /// Prove it's you with the current PIN (change, disable).
  current,

  /// Type a new PIN, 4–6 digits, then Continue.
  choose,

  /// Type it again.
  confirm,

  /// Finished; the page closes.
  done,
}

@freezed
abstract class PinSetupState with _$PinSetupState {
  const factory PinSetupState({
    required PinSetupStep step,
    @Default('') String digits,

    /// The PIN typed in [PinSetupStep.choose].
    @Default('') String chosen,
    @Default(false) bool mismatch,
    UnlockResult? rejected,
    Failure? failure,
    @Default(false) bool busy,
  }) = _PinSetupState;

  const PinSetupState._();

  bool get canContinue =>
      step == PinSetupStep.choose && digits.length >= Pin.minLength && !busy;
}

/// Turning the lock on, changing the PIN, or turning it off (PRD §6.4).
@riverpod
class PinSetupNotifier extends _$PinSetupNotifier {
  @override
  PinSetupState build(PinSetupMode mode) => PinSetupState(
    step: mode == PinSetupMode.enable
        ? PinSetupStep.choose
        : PinSetupStep.current,
  );

  AppLockNotifier get _lock => ref.read(appLockProvider.notifier);

  /// The length that submits automatically in the current step.
  int get _autoLength => switch (state.step) {
    PinSetupStep.current =>
      ref.read(appLockProvider).value?.settings.pinLength ?? 0,
    PinSetupStep.confirm => state.chosen.length,
    _ => 0,
  };

  Future<void> onKey(KeypadKey key) async {
    if (state.busy || state.step == PinSetupStep.done) return;
    if (state.rejected is UnlockThrottled) return;
    final max = state.step == PinSetupStep.choose ? Pin.maxLength : _autoLength;
    final digits = applyPinKey(state.digits, key, max: max);
    state = state.copyWith(
      digits: digits,
      mismatch: false,
      rejected: null,
      failure: null,
    );
    if (_autoLength > 0 && digits.length == _autoLength) {
      await (state.step == PinSetupStep.current
          ? _checkCurrent(digits)
          : _confirm(digits));
    }
  }

  /// Choose step: keep the typed PIN and ask for it again.
  void submitChosen() {
    if (!state.canContinue) return;
    state = state.copyWith(
      step: PinSetupStep.confirm,
      chosen: state.digits,
      digits: '',
    );
  }

  Future<void> _checkCurrent(String pin) async {
    state = state.copyWith(busy: true);
    final result = await _lock.checkPin(pin);
    if (!ref.mounted) return;
    final outcome = result.getRight().toNullable();
    if (outcome is! UnlockSuccess) {
      state = state.copyWith(
        busy: false,
        digits: '',
        rejected: outcome,
        failure: result.getLeft().toNullable(),
      );
      return;
    }
    if (mode == PinSetupMode.disable) {
      await _finish(_lock.disable());
    } else {
      state = state.copyWith(
        busy: false,
        digits: '',
        step: PinSetupStep.choose,
      );
    }
  }

  Future<void> _confirm(String pin) async {
    if (pin != state.chosen) {
      state = const PinSetupState(step: PinSetupStep.choose, mismatch: true);
      return;
    }
    state = state.copyWith(busy: true);
    await _finish(_lock.setPin(pin));
  }

  Future<void> _finish(Future<Failure?> write) async {
    final failure = await write;
    if (!ref.mounted) return;
    state = failure == null
        ? state.copyWith(busy: false, step: PinSetupStep.done)
        : state.copyWith(busy: false, digits: '', failure: failure);
  }
}
