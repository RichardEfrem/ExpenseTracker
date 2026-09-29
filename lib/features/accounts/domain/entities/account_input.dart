import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_input.freezed.dart';

/// What the user sets on an account (PRD ACC-01).
@freezed
abstract class AccountInput with _$AccountInput {
  const factory AccountInput({
    required String name,
    required AccountType type,
    required String icon,
    required PaletteColor color,

    /// Balance before the first recorded transaction; may be negative.
    @Default(0) int openingBalance,
  }) = _AccountInput;

  const AccountInput._();

  static const maxNameLength = 40;
  static const maxBalance = 999999999999999;

  /// Icon suggested for each type.
  static String defaultIcon(AccountType type) => switch (type) {
    AccountType.cash => 'payments',
    AccountType.bank => 'account_balance',
    AccountType.ewallet => 'account_balance_wallet',
    AccountType.other => 'savings',
  };

  Either<ValidationReason, AccountInput> validated() {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return const Left(ValidationReason.nameEmpty);
    if (trimmed.length > maxNameLength) {
      return const Left(ValidationReason.nameTooLong);
    }
    if (openingBalance.abs() > maxBalance) {
      return const Left(ValidationReason.amountTooLarge);
    }
    return Right(copyWith(name: trimmed));
  }
}
