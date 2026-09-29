import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

/// The OS biometric prompt (local_auth).
class BiometricDataSource {
  const BiometricDataSource(this._auth);

  final LocalAuthentication _auth;

  /// Supported hardware with at least one enrolled fingerprint or face.
  Future<bool> available() async =>
      await _auth.isDeviceSupported() &&
      (await _auth.getAvailableBiometrics()).isNotEmpty;

  /// True when the OS confirmed the user. Cancelling, lockouts and missing
  /// enrollment all return false: the PIN always remains.
  Future<bool> authenticate(String reason) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
      );
    } on LocalAuthException {
      return false;
    }
  }
}

/// FLAG_SECURE on the app window, via MainActivity's channel.
class SecureWindowDataSource {
  const SecureWindowDataSource([
    this._channel = const MethodChannel('expense_tracker/secure_window'),
  ]);

  final MethodChannel _channel;

  Future<void> setSecure({required bool secure}) =>
      _channel.invokeMethod<void>('setSecure', secure);
}
