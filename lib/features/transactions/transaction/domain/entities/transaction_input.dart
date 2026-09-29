import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_input.freezed.dart';

/// What the user enters on the Add/Edit screen (PRD TX-02).
@freezed
abstract class TransactionInput with _$TransactionInput {
  const factory TransactionInput({
    required TransactionType type,
    required int amount,
    required String accountId,
    String? toAccountId,
    String? categoryId,
    required LocalDate date,
    required LocalTime time,
    String? note,
  }) = _TransactionInput;

  const TransactionInput._();

  static const maxNoteLength = 200;

  /// Largest storable amount (15 digits), far above any real IDR amount.
  static const maxAmount = 999999999999999;

  /// The input normalized (trimmed note, blank → null, fields that don't
  /// apply to [type] cleared), or why it is invalid.
  Either<ValidationReason, TransactionInput> validated() {
    if (amount <= 0) return const Left(ValidationReason.amountNotPositive);
    if (amount > maxAmount) return const Left(ValidationReason.amountTooLarge);
    final trimmed = note?.trim();
    if (trimmed != null && trimmed.length > maxNoteLength) {
      return const Left(ValidationReason.noteTooLong);
    }
    if (accountId.isEmpty) return const Left(ValidationReason.accountRequired);
    if (type.needsCategory && (categoryId == null || categoryId!.isEmpty)) {
      return const Left(ValidationReason.categoryRequired);
    }
    if (type == TransactionType.transfer) {
      if (toAccountId == null) {
        return const Left(ValidationReason.accountRequired);
      }
      if (toAccountId == accountId) {
        return const Left(ValidationReason.sameAccount);
      }
    }
    return Right(
      copyWith(
        note: trimmed == null || trimmed.isEmpty ? null : trimmed,
        categoryId: type.needsCategory ? categoryId : null,
        toAccountId: switch (type) {
          TransactionType.transfer => toAccountId,
          // An adjustment's direction: set (to itself) means money in.
          TransactionType.adjustment =>
            toAccountId == accountId ? toAccountId : null,
          _ => null,
        },
      ),
    );
  }
}
