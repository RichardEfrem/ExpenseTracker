import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/features/accounts/presentation/providers/accounts_notifier.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/account_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lists the active accounts under [title]; the picked id, or null when
/// dismissed.
Future<String?> showAccountPicker(
  BuildContext context, {
  required String title,
}) => showModalBottomSheet<String>(
  context: context,
  useSafeArea: true,
  builder: (context) => Consumer(
    builder: (context, ref, _) {
      final accounts = ref.watch(accountsProvider()).value ?? const [];
      return ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.screenPadding),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          for (final a in accounts)
            ListTile(
              leading: AccountIcon(a),
              title: Text(a.name),
              onTap: () => Navigator.pop(context, a.id),
            ),
        ],
      );
    },
  ),
);
