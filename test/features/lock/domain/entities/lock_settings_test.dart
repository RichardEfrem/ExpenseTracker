import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/pin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('locksAfter (timeout)', () {
    for (final (timeout, away, locks) in [
      (LockTimeout.immediately, Duration.zero, true),
      (LockTimeout.immediately, const Duration(seconds: 1), true),
      (LockTimeout.seconds30, const Duration(seconds: 29), false),
      (LockTimeout.seconds30, const Duration(seconds: 30), true),
      (LockTimeout.minute1, const Duration(seconds: 59), false),
      (LockTimeout.minute1, const Duration(minutes: 1), true),
      (LockTimeout.minutes5, const Duration(minutes: 4, seconds: 59), false),
      (LockTimeout.minutes5, const Duration(hours: 3), true),
    ]) {
      test('${timeout.name}, away $away → $locks', () {
        expect(
          LockSettings(enabled: true, timeout: timeout).locksAfter(away),
          locks,
        );
      });
    }

    test('never while the lock is off', () {
      expect(
        const LockSettings(
          timeout: LockTimeout.immediately,
        ).locksAfter(const Duration(days: 1)),
        isFalse,
      );
    });

    test('defaults: off, 1 minute', () {
      expect(const LockSettings().enabled, isFalse);
      expect(const LockSettings().timeout, LockTimeout.minute1);
    });
  });

  test('a PIN is 4–6 digits', () {
    for (final ok in ['0000', '1234', '12345', '123456']) {
      expect(Pin.isValid(ok), isTrue, reason: ok);
    }
    for (final bad in ['', '123', '1234567', '12a4', ' 1234', '١٢٣٤']) {
      expect(Pin.isValid(bad), isFalse, reason: bad);
    }
  });

  group('throttle', () {
    final last = DateTime(2026, 9, 29, 12);
    test('five free tries, then a 30 s wait after each miss', () {
      expect(PinThrottle.retryAt(4, last), isNull);
      expect(
        PinThrottle.retryAt(5, last),
        last.add(const Duration(seconds: 30)),
      );
      expect(
        PinThrottle.retryAt(9, last),
        last.add(const Duration(seconds: 30)),
      );
      expect(PinThrottle.retryAt(5, null), isNull);
    });
    test('tries left', () {
      expect(
        [for (var n = 0; n <= 6; n++) PinThrottle.triesLeft(n)],
        [5, 4, 3, 2, 1, 0, 0],
      );
    });
  });
}
