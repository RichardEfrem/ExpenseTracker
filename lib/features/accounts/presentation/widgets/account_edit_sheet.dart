import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/category_icons.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_input.dart';
import 'package:expense_tracker/features/accounts/presentation/providers/accounts_notifier.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/account_labels.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/money_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _accountIcons = [
  'payments',
  'account_balance',
  'account_balance_wallet',
  'savings',
  'phone_iphone',
  'attach_money',
  'currency_exchange',
  'work',
];

/// Create or edit an account (PRD ACC-01).
Future<void> showAccountEditSheet(BuildContext context, {Account? existing}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _AccountEditSheet(existing: existing),
    );

class _AccountEditSheet extends ConsumerStatefulWidget {
  const _AccountEditSheet({this.existing});

  final Account? existing;

  @override
  ConsumerState<_AccountEditSheet> createState() => _AccountEditSheetState();
}

class _AccountEditSheetState extends ConsumerState<_AccountEditSheet> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late final _opening = TextEditingController(
    text: widget.existing == null
        ? ''
        : MoneyField.initialText(widget.existing!.openingBalance),
  );
  late var _type = widget.existing?.type ?? AccountType.bank;
  late var _icon = widget.existing?.icon ?? AccountInput.defaultIcon(_type);
  late var _color = widget.existing?.color ?? PaletteColor.blue;
  String? _error;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    _opening.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final input = AccountInput(
      name: _name.text,
      type: _type,
      icon: _icon,
      color: _color,
      openingBalance: MoneyField.valueOf(_opening) ?? 0,
    );
    final actions = ref.read(accountActionsProvider.notifier);
    final existing = widget.existing;
    final failure = existing == null
        ? (await actions.create(input)).getLeft().toNullable()
        : await actions.update(existing.id, input);
    if (!mounted) return;
    if (failure == null) {
      Navigator.pop(context);
    } else {
      setState(() => _error = failureMessage(l10n, failure));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final finance = FinanceColors.of(context);
    final primary = theme.colorScheme.primary;

    Widget ring({required bool selected, required Widget child}) => Container(
      width: Dimens.minTouchTarget,
      height: Dimens.minTouchTarget,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? primary : Colors.transparent,
          width: Dimens.selectedRingWidth,
        ),
      ),
      child: child,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          Dimens.screenPadding,
          0,
          Dimens.screenPadding,
          Dimens.screenPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.existing == null ? l10n.accounts_new : l10n.accounts_edit,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: Dimens.space4),
            Row(
              children: [
                IconCircle(
                  icon: CategoryIcons.of(_icon),
                  color: finance.category(_color),
                  size: 48,
                ),
                const SizedBox(width: Dimens.space3),
                Expanded(
                  child: TextField(
                    key: const ValueKey('account-name'),
                    controller: _name,
                    autofocus: widget.existing == null,
                    maxLength: AccountInput.maxNameLength,
                    decoration: InputDecoration(
                      labelText: l10n.categories_name,
                      errorText: _error,
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space4),
            Wrap(
              spacing: Dimens.space2,
              runSpacing: Dimens.space2,
              children: [
                for (final type in AccountType.values)
                  ChoiceChip(
                    label: Text(accountTypeLabel(l10n, type)),
                    selected: _type == type,
                    onSelected: (_) => setState(() {
                      if (_icon == AccountInput.defaultIcon(_type)) {
                        _icon = AccountInput.defaultIcon(type);
                      }
                      _type = type;
                    }),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space4),
            MoneyField(
              key: const ValueKey('account-opening'),
              controller: _opening,
              label: l10n.accounts_opening_balance,
              allowNegative: true,
            ),
            const SizedBox(height: Dimens.space4),
            Text(l10n.categories_color, style: theme.textTheme.titleMedium),
            Wrap(
              children: [
                for (final color in PaletteColor.values)
                  InkResponse(
                    onTap: () => setState(() => _color = color),
                    child: ring(
                      selected: color == _color,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: finance.category(color),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space2),
            Text(l10n.categories_icon, style: theme.textTheme.titleMedium),
            Wrap(
              children: [
                for (final icon in _accountIcons)
                  InkResponse(
                    onTap: () => setState(() => _icon = icon),
                    child: ring(
                      selected: icon == _icon,
                      child: Icon(
                        CategoryIcons.of(icon),
                        color: theme.colorScheme.onSurfaceVariant,
                        semanticLabel: icon.replaceAll('_', ' '),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space6),
            SizedBox(
              height: Dimens.primaryButtonHeight,
              child: FilledButton(
                key: const ValueKey('account-save'),
                onPressed: _name.text.trim().isEmpty ? null : _save,
                child: Text(l10n.common_save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
