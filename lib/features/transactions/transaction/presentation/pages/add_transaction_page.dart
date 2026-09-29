import 'dart:async';

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/motion.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/relative_day.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/transaction_form_notifier.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/transaction_form_state.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/amount_hero.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/note_dialog.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_feedback.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_type_selector.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transfer_accounts_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Add or edit a transaction (DESIGN §8.2): amount keypad first, category
/// grid with the last-used one preselected, optional date/note chips.
class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({
    this.initialType = TransactionType.expense,
    this.editId,
    super.key,
  });

  final TransactionType initialType;
  final String? editId;

  @override
  ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
  /// Shows the check on Save for a moment before closing.
  var _justSaved = false;

  TransactionFormNotifierProvider get _provider =>
      transactionFormProvider(widget.initialType, editId: widget.editId);

  Future<void> _save() async {
    final saved = await ref.read(_provider.notifier).save();
    if (!saved || !mounted) return;
    unawaited(HapticFeedback.lightImpact());
    setState(() => _justSaved = true);
    await Future<void>.delayed(motionDuration(context, Motion.saveCheck));
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _pickDate(TransactionFormState state) async {
    final today = LocalDate.today(ref.read(clockProvider));
    final picked = await showDatePicker(
      context: context,
      initialDate: state.date.toDateTime(),
      firstDate: DateTime(2000),
      lastDate: today.addDays(365 * 5).toDateTime(),
    );
    if (picked != null) {
      ref.read(_provider.notifier).setDate(LocalDate.fromDateTime(picked));
    }
  }

  Future<void> _editNote(TransactionFormState state) async {
    final note = await showNoteDialog(context, initial: state.note);
    if (note != null) ref.read(_provider.notifier).setNote(note);
  }

  Future<void> _pickAccount({required bool destination}) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showAccountPicker(
      context,
      title: destination ? l10n.transfer_to : l10n.detail_account,
    );
    if (picked == null) return;
    final notifier = ref.read(_provider.notifier);
    destination ? notifier.setToAccount(picked) : notifier.setAccount(picked);
  }

  Future<void> _createCategory(CategoryType type) async {
    final created = await showCategoryEditSheet(context, type: type);
    if (created != null) {
      ref.read(_provider.notifier).selectCategory(created.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ref.listen(_provider.select((s) => s.value?.failure), (_, failure) {
      if (failure != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(failureMessage(l10n, failure))),
          );
      }
    });
    final async = ref.watch(_provider);
    final editing = widget.editId != null;

    return Scaffold(
      appBar: AppBar(
        leading: editing
            ? const BackButton()
            : IconButton(
                tooltip: l10n.common_close,
                icon: const Icon(Symbols.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: editing ? Text(l10n.edit_transaction_title) : null,
        actions: [
          if (editing)
            IconButton(
              tooltip: l10n.common_delete,
              icon: const Icon(Symbols.delete_rounded),
              onPressed: () {
                deleteTransactionWithUndo(context, widget.editId!);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: switch (async) {
        AsyncData(:final value) => _Body(
          state: value,
          justSaved: _justSaved,
          onKey: ref.read(_provider.notifier).onKey,
          onType: ref.read(_provider.notifier).setType,
          onCategory: ref.read(_provider.notifier).selectCategory,
          onCreateCategory: _createCategory,
          onPickDate: () => _pickDate(value),
          onEditNote: () => _editNote(value),
          onPickAccount: () => _pickAccount(destination: false),
          onPickToAccount: () => _pickAccount(destination: true),
          onSave: _save,
        ),
        AsyncError(:final error) => Center(
          child: EmptyState(
            icon: Symbols.error_rounded,
            message: error is Failure
                ? failureMessage(l10n, error)
                : l10n.failure_unexpected,
            actionLabel: l10n.common_retry,
            onAction: () => ref.invalidate(_provider),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.state,
    required this.justSaved,
    required this.onKey,
    required this.onType,
    required this.onCategory,
    required this.onCreateCategory,
    required this.onPickDate,
    required this.onEditNote,
    required this.onPickAccount,
    required this.onPickToAccount,
    required this.onSave,
  });

  final TransactionFormState state;
  final bool justSaved;
  final ValueChanged<KeypadKey> onKey;
  final ValueChanged<TransactionType> onType;
  final ValueChanged<String> onCategory;
  final ValueChanged<CategoryType> onCreateCategory;
  final VoidCallback onPickDate;
  final VoidCallback onEditNote;
  final VoidCallback onPickAccount;
  final VoidCallback onPickToAccount;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final today = LocalDate.today(ref.watch(clockProvider));
    final accounts = ref.watch(accountsProvider()).value ?? const [];
    String nameOf(String id) =>
        accounts.where((a) => a.id == id).firstOrNull?.name ?? '';
    final categoryType = categoryTypeOf(state.type);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: Dimens.space4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.screenPadding,
                    ),
                    child: TransactionTypeSelector(
                      selected: state.type,
                      onChanged: state.isEditing ? null : onType,
                    ),
                  ),
                  const SizedBox(height: Dimens.space6),
                  AmountHero(
                    type: state.type,
                    expression: state.expression,
                    amount: state.amount,
                  ),
                  const SizedBox(height: Dimens.space4),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.screenPadding,
                    ),
                    child: Wrap(
                      spacing: Dimens.space2,
                      runSpacing: Dimens.space2,
                      alignment: WrapAlignment.center,
                      children: [
                        ActionChip(
                          key: const ValueKey('date-chip'),
                          avatar: const Icon(Symbols.calendar_today_rounded),
                          label: Text(
                            relativeDayLabel(l10n, state.date, today),
                          ),
                          onPressed: onPickDate,
                        ),
                        if (accounts.length > 1 &&
                            state.type != TransactionType.transfer)
                          ActionChip(
                            key: const ValueKey('account-chip'),
                            avatar: const Icon(
                              Symbols.account_balance_wallet_rounded,
                            ),
                            label: Text(nameOf(state.accountId)),
                            onPressed: onPickAccount,
                          ),
                        ActionChip(
                          key: const ValueKey('note-chip'),
                          avatar: const Icon(Symbols.edit_note_rounded),
                          label: Text(
                            state.note ?? l10n.add_note,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: onEditNote,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimens.space4),
                  if (state.type == TransactionType.transfer)
                    TransferAccountsField(
                      canTransfer: accounts.length > 1,
                      from: nameOf(state.accountId),
                      to: state.toAccountId == null
                          ? null
                          : nameOf(state.toAccountId!),
                      onFrom: onPickAccount,
                      onTo: onPickToAccount,
                    ),
                  if (categoryType != null)
                    CategoryGrid(
                      type: categoryType,
                      selectedId: state.categoryId,
                      firstId: state.firstCategoryId,
                      shrinkWrap: true,
                      onSelected: (c) => onCategory(c.id),
                      onCreateNew: () => onCreateCategory(categoryType),
                    ),
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.screenPadding,
              Dimens.space2,
              Dimens.screenPadding,
              0,
            ),
            child: AmountKeypad(onKey: onKey),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.screenPadding),
            child: SizedBox(
              width: double.infinity,
              height: Dimens.primaryButtonHeight,
              child: FilledButton(
                key: const ValueKey('save'),
                onPressed: state.canSave && !justSaved ? onSave : null,
                child: justSaved
                    ? Icon(Symbols.check_rounded, semanticLabel: l10n.saved)
                    : Text(l10n.common_save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
