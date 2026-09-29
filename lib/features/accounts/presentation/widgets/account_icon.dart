import 'package:expense_tracker/core/theme/category_icons.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:flutter/material.dart';

/// An account's icon circle; reads as the account name.
class AccountIcon extends StatelessWidget {
  const AccountIcon(this.account, {this.size = 36, super.key});

  final Account account;
  final double size;

  @override
  Widget build(BuildContext context) => IconCircle(
    icon: CategoryIcons.of(account.icon),
    color: FinanceColors.of(context).category(account.color),
    size: size,
    semanticLabel: account.name,
  );
}
