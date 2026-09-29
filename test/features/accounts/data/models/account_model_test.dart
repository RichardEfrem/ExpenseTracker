import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/accounts/data/models/account_model.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const input = AccountInput(
    name: 'GoPay',
    type: AccountType.ewallet,
    icon: 'account_balance_wallet',
    color: PaletteColor.teal,
    openingBalance: -25000,
  );

  test('payload keyed by column, every field present', () {
    expect(input.toJson(), {
      'name': 'GoPay',
      'type': 'ewallet',
      'icon': 'account_balance_wallet',
      'color': 'teal',
      'opening_balance': -25000,
    });
  });

  test('validation trims and bounds the name', () {
    expect(
      input.copyWith(name: '  GoPay ').validated().toNullable()!.name,
      'GoPay',
    );
    expect(
      input.copyWith(name: ' ').validated().getLeft().toNullable(),
      ValidationReason.nameEmpty,
    );
    expect(
      input.copyWith(name: 'x' * 41).validated().getLeft().toNullable(),
      ValidationReason.nameTooLong,
    );
  });

  test('default icon per type', () {
    expect(AccountInput.defaultIcon(AccountType.cash), 'payments');
    expect(AccountInput.defaultIcon(AccountType.bank), 'account_balance');
  });
}
