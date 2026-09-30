import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/tags/tags_domain.dart';
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

    /// Tag names as typed; [validated] normalizes them (see [Tag.normalize]).
    @Default(<String>[]) List<String> tags,
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
    final tagNames = <String>{};
    for (final raw in tags) {
      final name = Tag.normalize(raw);
      if (name == null) continue;
      if (name.length > Tag.maxLength) {
        return const Left(ValidationReason.tagTooLong);
      }
      tagNames.add(name);
    }
    if (tagNames.length > Tag.maxPerTransaction) {
      return const Left(ValidationReason.tooManyTags);
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
        tags: tagNames.toList()..sort(),
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
