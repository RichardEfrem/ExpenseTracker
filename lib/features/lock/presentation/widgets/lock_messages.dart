import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/domain/entities/unlock_result.dart';

/// "Wrong PIN. 3 more tries…" / "Too many tries. Try again in 30 s." for a
/// rejected try at [now]; the failure's message otherwise.
String? unlockMessage(
  AppLocalizations l10n,
  DateTime now, {
  UnlockResult? rejected,
  Failure? failure,
}) {
  if (failure != null) return failureMessage(l10n, failure);
  return switch (rejected) {
    UnlockWrongPin(:final triesLeft) => l10n.lock_wrong_pin(triesLeft),
    UnlockThrottled(:final retryAt) => l10n.lock_wait(
      (retryAt.difference(now).inMilliseconds / 1000).ceil().clamp(1, 3600),
    ),
    _ => null,
  };
}

String lockTimeoutLabel(AppLocalizations l10n, LockTimeout timeout) =>
    switch (timeout) {
      LockTimeout.immediately => l10n.lock_timeout_immediately,
      LockTimeout.seconds30 => l10n.lock_timeout_seconds30,
      LockTimeout.minute1 => l10n.lock_timeout_minute1,
      LockTimeout.minutes5 => l10n.lock_timeout_minutes5,
    };
