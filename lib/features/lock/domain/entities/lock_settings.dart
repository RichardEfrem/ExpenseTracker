import 'package:freezed_annotation/freezed_annotation.dart';

part 'lock_settings.freezed.dart';

/// Time away from the app before it asks for the PIN again (PRD §6.4).
enum LockTimeout {
  immediately(Duration.zero),
  seconds30(Duration(seconds: 30)),
  minute1(Duration(minutes: 1)),
  minutes5(Duration(minutes: 5));

  const LockTimeout(this.duration);

  final Duration duration;
}

/// App lock configuration (PRD US-13, §6.4). Kept in secure storage, never
/// in the database, so a restored backup can't turn on a lock without its
/// PIN.
@freezed
abstract class LockSettings with _$LockSettings {
  const factory LockSettings({
    /// A PIN is set, so the app locks.
    @Default(false) bool enabled,

    /// Digits in the PIN (4–6), for the dots; 0 while off.
    @Default(0) int pinLength,

    /// Fingerprint/face may unlock instead of the PIN.
    @Default(false) bool biometric,
    @Default(LockTimeout.minute1) LockTimeout timeout,
  }) = _LockSettings;

  const LockSettings._();

  /// Whether coming back after [away] in the background needs unlocking.
  bool locksAfter(Duration away) => enabled && away >= timeout.duration;
}
