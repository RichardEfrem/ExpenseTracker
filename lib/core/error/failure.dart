import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Typed error returned (never thrown) by repositories and use cases.
///
/// Presentation maps each case to a localized message; [detail] is for logs
/// only and never shown to the user.
@freezed
sealed class Failure with _$Failure {
  const factory Failure.database([String? detail]) = DatabaseFailure;
  const factory Failure.validation(ValidationReason reason) = ValidationFailure;
  const factory Failure.notFound([String? detail]) = NotFoundFailure;
  const factory Failure.file([String? detail]) = FileFailure;
  const factory Failure.backup(BackupProblem problem, [String? detail]) =
      BackupFailure;
  const factory Failure.unexpected([String? detail]) = UnexpectedFailure;
}

/// Why an input was rejected. Each value has a localized message.
enum ValidationReason {
  invalidInput,
  nameEmpty,
  nameTooLong,
  categoryInUse,
  categoryTypeMismatch,
  mergeIntoSelf,
  monthStartDayOutOfRange,
  weekStartOutOfRange,
  amountNotPositive,
  amountTooLarge,
  noteTooLong,
  categoryRequired,
  accountRequired,
  sameAccount,
  accountInUse,
  lastActiveAccount,
  intervalOutOfRange,
  dayOfMonthOutOfRange,
  endBeforeStart,
  pinInvalid,
}

/// Why a backup file could not be read or restored.
enum BackupProblem { corruptFile, unsupportedVersion, emptyFile }

/// Carries a [Failure] through code that has to throw (e.g. inside a DB
/// transaction callback, so the transaction rolls back). [guard] unwraps it.
class FailureException implements Exception {
  const FailureException(this.failure);

  final Failure failure;

  @override
  String toString() => 'FailureException($failure)';
}
