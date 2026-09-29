import 'package:freezed_annotation/freezed_annotation.dart';

part 'unlock_result.freezed.dart';

/// The outcome of a PIN try.
@freezed
sealed class UnlockResult with _$UnlockResult {
  const factory UnlockResult.success() = UnlockSuccess;

  /// Wrong PIN; [triesLeft] free tries before a wait.
  const factory UnlockResult.wrongPin({required int triesLeft}) =
      UnlockWrongPin;

  /// Too many misses: no try is checked before [retryAt].
  const factory UnlockResult.throttled({required DateTime retryAt}) =
      UnlockThrottled;
}
