import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';

String accountTypeLabel(AppLocalizations l10n, AccountType type) =>
    switch (type) {
      AccountType.cash => l10n.account_type_cash,
      AccountType.bank => l10n.account_type_bank,
      AccountType.ewallet => l10n.account_type_ewallet,
      AccountType.other => l10n.account_type_other,
    };
