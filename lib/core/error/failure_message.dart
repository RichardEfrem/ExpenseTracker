import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';

/// The user-facing message for [failure].
String failureMessage(AppLocalizations l10n, Failure failure) =>
    switch (failure) {
      DatabaseFailure() => l10n.failure_database,
      ValidationFailure(:final reason) => validationMessage(l10n, reason),
      NotFoundFailure() => l10n.failure_not_found,
      FileFailure() => l10n.failure_file,
      BackupFailure(:final problem) => switch (problem) {
        BackupProblem.corruptFile => l10n.failure_backup_corrupt,
        BackupProblem.unsupportedVersion => l10n.failure_backup_version,
        BackupProblem.emptyFile => l10n.failure_backup_empty,
        BackupProblem.wrongPassword => l10n.failure_backup_password,
      },
      UnexpectedFailure() => l10n.failure_unexpected,
    };

String validationMessage(AppLocalizations l10n, ValidationReason reason) =>
    switch (reason) {
      ValidationReason.invalidInput => l10n.validation_invalid_input,
      ValidationReason.nameEmpty => l10n.validation_name_empty,
      ValidationReason.nameTooLong => l10n.validation_name_too_long,
      ValidationReason.categoryInUse => l10n.validation_category_in_use,
      ValidationReason.categoryTypeMismatch =>
        l10n.validation_category_type_mismatch,
      ValidationReason.mergeIntoSelf => l10n.validation_merge_into_self,
      ValidationReason.monthStartDayOutOfRange =>
        l10n.validation_month_start_day,
      ValidationReason.weekStartOutOfRange => l10n.validation_week_start,
      ValidationReason.amountNotPositive => l10n.validation_amount_positive,
      ValidationReason.amountTooLarge => l10n.validation_amount_too_large,
      ValidationReason.noteTooLong => l10n.validation_note_too_long,
      ValidationReason.categoryRequired => l10n.validation_category_required,
      ValidationReason.accountRequired => l10n.validation_account_required,
      ValidationReason.sameAccount => l10n.validation_same_account,
      ValidationReason.accountInUse => l10n.validation_account_in_use,
      ValidationReason.lastActiveAccount => l10n.validation_last_account,
      ValidationReason.intervalOutOfRange => l10n.validation_interval,
      ValidationReason.dayOfMonthOutOfRange => l10n.validation_month_start_day,
      ValidationReason.endBeforeStart => l10n.validation_end_before_start,
      ValidationReason.pinInvalid => l10n.validation_pin,
      ValidationReason.passwordTooShort => l10n.validation_password_short,
      ValidationReason.tagTooLong => l10n.validation_tag_too_long,
      ValidationReason.tooManyTags => l10n.validation_too_many_tags,
    };
