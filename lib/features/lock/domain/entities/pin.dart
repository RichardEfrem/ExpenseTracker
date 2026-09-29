/// PIN rules (PRD §6.4): 4–6 digits.
abstract final class Pin {
  static const minLength = 4;
  static const maxLength = 6;

  static final _pattern = RegExp(r'^\d{4,6}$');

  static bool isValid(String pin) => _pattern.hasMatch(pin);
}

/// Wrong-PIN throttling: after [freeAttempts] misses in a row, every
/// further try waits [wait] after the last miss.
abstract final class PinThrottle {
  static const freeAttempts = 5;
  static const wait = Duration(seconds: 30);

  /// When the next try is allowed; null while tries are free.
  static DateTime? retryAt(int failures, DateTime? lastFailure) =>
      failures < freeAttempts || lastFailure == null
      ? null
      : lastFailure.add(wait);

  /// Free tries left before the wait starts.
  static int triesLeft(int failures) =>
      (freeAttempts - failures).clamp(0, freeAttempts);
}
