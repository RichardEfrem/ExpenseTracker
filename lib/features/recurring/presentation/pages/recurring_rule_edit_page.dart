import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_notifiers.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_rule_form_notifier.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_rule_form_state.dart';
import 'package:expense_tracker/features/recurring/presentation/widgets/recurring_labels.dart';
import 'package:expense_tracker/features/recurring/presentation/widgets/repeat_sheet.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// New or edit a recurring rule (DESIGN §8.9): the Add screen layout plus
/// Repeat, start and end chips.
class RecurringRuleEditPage extends ConsumerWidget {
  const RecurringRuleEditPage({this.editId, super.key});

  final String? editId;

  RecurringRuleFormNotifierProvider get _provider =>
      recurringRuleFormProvider(editId: editId);

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final saved = await ref.read(_provider.notifier).save();
    if (!saved) return;
    messenger.showSnackBar(SnackBar(content: Text(l10n.recurring_saved)));
    navigator.pop();
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.recurring_delete_title),
        content: Text(l10n.recurring_delete_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.common_delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final failure = await ref
        .read(recurringActionsProvider.notifier)
        .delete(editId!);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            failure == null
                ? l10n.recurring_deleted
                : failureMessage(l10n, failure),
          ),
        ),
      );
    if (failure == null) navigator.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final editing = editId != null;
    return Scaffold(
      appBar: AppBar(
        leading: editing
            ? const BackButton()
            : IconButton(
                tooltip: l10n.common_close,
                icon: const Icon(Symbols.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
        title: Text(editing ? l10n.recurring_edit : l10n.recurring_new),
        actions: [
          if (editing)
            IconButton(
              tooltip: l10n.common_delete,
              icon: const Icon(Symbols.delete_rounded),
              onPressed: () => _delete(context, ref),
            ),
        ],
      ),
      body: switch (ref.watch(_provider)) {
        AsyncData(:final value) => _Body(
          state: value,
          notifier: ref.read(_provider.notifier),
          onSave: () => _save(context, ref),
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
    required this.notifier,
    required this.onSave,
  });

  final RecurringRuleFormState state;
  final RecurringRuleFormNotifier notifier;
  final VoidCallback onSave;

  Future<void> _pickRepeat(BuildContext context) async {
    final choice = await showRepeatSheet(
      context,
      initial: (
        frequency: state.frequency,
        interval: state.interval,
        dayOfMonth: state.effectiveDayOfMonth,
      ),
    );
    if (choice == null) return;
    notifier.setSchedule(
      frequency: choice.frequency,
      interval: choice.interval,
      // Keep following the start day unless a different day was picked.
      dayOfMonth: choice.dayOfMonth == state.startDate.day
          ? null
          : choice.dayOfMonth,
    );
  }

  Future<LocalDate?> _pickDate(
    BuildContext context,
    LocalDate initial, {
    required LocalDate first,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.toDateTime(),
      firstDate: first.toDateTime(),
      lastDate: DateTime(2100),
    );
    return picked == null ? null : LocalDate.fromDateTime(picked);
  }

  Future<void> _pickAccount(
    BuildContext context, {
    required bool destination,
  }) async {
    final l10n = AppLocalizations.of(context);
    final picked = await showAccountPicker(
      context,
      title: destination ? l10n.transfer_to : l10n.detail_account,
    );
    if (picked == null) return;
    destination ? notifier.setToAccount(picked) : notifier.setAccount(picked);
  }

  Future<void> _createCategory(BuildContext context, CategoryType type) async {
    final created = await showCategoryEditSheet(context, type: type);
    if (created != null) notifier.selectCategory(created.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final accounts = ref.watch(accountsProvider()).value ?? const [];
    String nameOf(String id) =>
        accounts.where((a) => a.id == id).firstOrNull?.name ?? '';
    final categoryType = categoryTypeOf(state.type);
    final end = state.endDate;

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
                      onChanged: notifier.setType,
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
                          key: const ValueKey('repeat-chip'),
                          avatar: const Icon(Symbols.repeat_rounded),
                          label: Text(
                            scheduleLabel(
                              l10n,
                              frequency: state.frequency,
                              interval: state.interval,
                              dayOfMonth: state.effectiveDayOfMonth,
                            ),
                          ),
                          onPressed: () => _pickRepeat(context),
                        ),
                        ActionChip(
                          key: const ValueKey('start-chip'),
                          avatar: const Icon(Symbols.calendar_today_rounded),
                          label: Text(
                            l10n.recurring_starts(
                              AppDateFormat.dayMonthYear(state.startDate),
                            ),
                          ),
                          onPressed: () async {
                            final date = await _pickDate(
                              context,
                              state.startDate,
                              first: LocalDate(2000, 1, 1),
                            );
                            if (date != null) notifier.setStartDate(date);
                          },
                        ),
                        InputChip(
                          key: const ValueKey('end-chip'),
                          avatar: const Icon(Symbols.event_busy_rounded),
                          label: Text(
                            end == null
                                ? l10n.recurring_no_end
                                : l10n.recurring_ends(
                                    AppDateFormat.dayMonthYear(end),
                                  ),
                          ),
                          deleteButtonTooltipMessage: l10n.recurring_no_end,
                          onDeleted: end == null
                              ? null
                              : () => notifier.setEndDate(null),
                          onPressed: () async {
                            final date = await _pickDate(
                              context,
                              end ?? state.startDate,
                              first: state.startDate,
                            );
                            if (date != null) notifier.setEndDate(date);
                          },
                        ),
                        if (accounts.length > 1 &&
                            state.type != TransactionType.transfer)
                          ActionChip(
                            key: const ValueKey('account-chip'),
                            avatar: const Icon(
                              Symbols.account_balance_wallet_rounded,
                            ),
                            label: Text(nameOf(state.accountId)),
                            onPressed: () =>
                                _pickAccount(context, destination: false),
                          ),
                        ActionChip(
                          key: const ValueKey('note-chip'),
                          avatar: const Icon(Symbols.edit_note_rounded),
                          label: Text(
                            state.note ?? l10n.add_note,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onPressed: () async {
                            final note = await showNoteDialog(
                              context,
                              initial: state.note,
                            );
                            if (note != null) notifier.setNote(note);
                          },
                        ),
                        FilterChip(
                          key: const ValueKey('ask-first'),
                          label: Text(l10n.recurring_ask_first),
                          selected: !state.autoCreate,
                          onSelected: (ask) =>
                              notifier.setAutoCreate(autoCreate: !ask),
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
                      onFrom: () => _pickAccount(context, destination: false),
                      onTo: () => _pickAccount(context, destination: true),
                    ),
                  if (categoryType != null)
                    CategoryGrid(
                      type: categoryType,
                      selectedId: state.categoryId,
                      firstId: state.firstCategoryId,
                      shrinkWrap: true,
                      onSelected: (c) => notifier.selectCategory(c.id),
                      onCreateNew: () => _createCategory(context, categoryType),
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
            child: AmountKeypad(onKey: notifier.onKey),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.screenPadding),
            child: SizedBox(
              width: double.infinity,
              height: Dimens.primaryButtonHeight,
              child: FilledButton(
                key: const ValueKey('save'),
                onPressed: state.canSave ? onSave : null,
                child: Text(l10n.common_save),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
