import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';

extension AccountRowMapper on AccountRow {
  Account toEntity() => Account(
    id: id,
    name: name,
    type: AccountType.values.firstWhere(
      (t) => t.name == type,
      orElse: () => AccountType.other,
    ),
    icon: icon,
    color: PaletteColor.fromName(color),
    openingBalance: openingBalance,
    isArchived: isArchived,
    sortOrder: sortOrder,
    createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt, isUtc: true),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt, isUtc: true),
  );
}

extension AccountInputJson on AccountInput {
  /// The write payload, keyed by `accounts` column; every field is always
  /// written (all are required).
  Map<String, Object?> toJson() => {
    'name': name,
    'type': type.name,
    'icon': icon,
    'color': color.name,
    'opening_balance': openingBalance,
  };
}
