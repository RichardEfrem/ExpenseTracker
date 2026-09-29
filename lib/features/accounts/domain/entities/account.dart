import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

enum AccountType { cash, bank, ewallet, other }

/// A wallet that holds money (PRD §4.3).
@freezed
abstract class Account with _$Account {
  const factory Account({
    required String id,
    required String name,
    required AccountType type,

    /// Icon key (see `CategoryIcons`).
    required String icon,
    required PaletteColor color,
    required int openingBalance,
    required bool isArchived,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Account;
}
