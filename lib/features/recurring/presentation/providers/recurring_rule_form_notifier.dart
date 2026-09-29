import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/ref_once.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/recurring/data/recurring_providers.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_notifiers.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_rule_form_state.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recurring_rule_form_notifier.g.dart';

/// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
/// schedule. New rules default to monthly from today, created automatically.
@riverpod
class RecurringRuleFormNotifier extends _$RecurringRuleFormNotifier {
  /// First active category per type, preselected when the type changes.
  final _firstCategory = <TransactionType, String?>{};

  /// Active account ids, for picking a transfer destination.
  var _accounts = <String>[];

  String? _otherAccount(String accountId) =>
      _accounts.where((id) => id != accountId).firstOrNull;

  @override
  Future<RecurringRuleFormState> build({String? editId}) async {
    for (final type in TransactionType.values) {
      final categoryType = categoryTypeOf(type);
      if (categoryType == null) continue;
      final active = await ref.once(categoriesProvider(categoryType));
      _firstCategory[type] = active.firstOrNull?.id;
    }
    final accounts = await ref.once(accountsProvider());
    _accounts = [for (final a in accounts) a.id];

    if (editId != null) {
      final rule = (await ref.read(getRecurringRuleProvider)(
        editId,
      )).getOrThrow();
      return RecurringRuleFormState(
        editingId: rule.id,
        type: rule.type,
        expression: '${rule.amount}',
        amount: rule.amount,
        categoryId: rule.categoryId,
        firstCategoryId: rule.categoryId,
        accountId: rule.accountId,
        toAccountId: rule.toAccountId,
        note: rule.note,
        frequency: rule.frequency,
        interval: rule.interval,
        dayOfMonth: rule.dayOfMonth,
        startDate: rule.startDate,
        endDate: rule.endDate,
        autoCreate: rule.autoCreate,
      );
    }
    final account = await ref.once(defaultAccountProvider);
    return RecurringRuleFormState(
      type: TransactionType.expense,
      categoryId: _firstCategory[TransactionType.expense],
      firstCategoryId: _firstCategory[TransactionType.expense],
      accountId: account.id,
      frequency: RecurrenceFrequency.monthly,
      startDate: LocalDate.today(ref.read(clockProvider)),
    );
  }

  void _update(RecurringRuleFormState Function(RecurringRuleFormState) change) {
    final current = state.value;
    if (current != null) state = AsyncData(change(current));
  }

  void onKey(KeypadKey key) => _update((s) {
    final expression = applyKeypadKey(s.expression, key);
    return s.copyWith(
      expression: expression,
      amount: ref
          .read(evaluateAmountExpressionProvider)(expression)
          .toNullable(),
      failure: null,
    );
  });

  void setType(TransactionType type) => _update(
    (s) => s.type == type
        ? s
        : s.copyWith(
            type: type,
            categoryId: _firstCategory[type],
            firstCategoryId: _firstCategory[type],
            toAccountId: type == TransactionType.transfer
                ? s.toAccountId ?? _otherAccount(s.accountId)
                : null,
            failure: null,
          ),
  );

  /// The account (transfers: the source). Picking the current destination
  /// as source swaps the two.
  void setAccount(String id) => _update(
    (s) => s.copyWith(
      accountId: id,
      toAccountId: s.toAccountId == id ? s.accountId : s.toAccountId,
      failure: null,
    ),
  );

  void setToAccount(String id) => _update(
    (s) => s.copyWith(
      toAccountId: id,
      accountId: s.accountId == id
          ? (s.toAccountId ?? s.accountId)
          : s.accountId,
      failure: null,
    ),
  );

  void selectCategory(String id) =>
      _update((s) => s.copyWith(categoryId: id, failure: null));

  void setNote(String? note) => _update(
    (s) => s.copyWith(note: note == null || note.trim().isEmpty ? null : note),
  );

  void setSchedule({
    required RecurrenceFrequency frequency,
    required int interval,
    int? dayOfMonth,
  }) => _update(
    (s) => s.copyWith(
      frequency: frequency,
      interval: interval,
      dayOfMonth: dayOfMonth,
      failure: null,
    ),
  );

  /// Moves the start; an end before it is dropped.
  void setStartDate(LocalDate date) => _update(
    (s) => s.copyWith(
      startDate: date,
      endDate: s.endDate != null && s.endDate! < date ? null : s.endDate,
      failure: null,
    ),
  );

  void setEndDate(LocalDate? date) =>
      _update((s) => s.copyWith(endDate: date, failure: null));

  void setAutoCreate({required bool autoCreate}) =>
      _update((s) => s.copyWith(autoCreate: autoCreate));

  /// Saves, then generates anything already due; true on success. A
  /// failure is kept in the state for display.
  Future<bool> save() async {
    final s = state.value;
    if (s == null || !s.canSave) return false;
    _update((s) => s.copyWith(saving: true, failure: null));
    final input = RecurringRuleInput(
      type: s.type,
      amount: s.amount!,
      accountId: s.accountId,
      toAccountId: s.toAccountId,
      categoryId: s.categoryId,
      note: s.note,
      frequency: s.frequency,
      interval: s.interval,
      dayOfMonth: s.frequency == RecurrenceFrequency.monthly
          ? s.effectiveDayOfMonth
          : null,
      startDate: s.startDate,
      endDate: s.endDate,
      autoCreate: s.autoCreate,
    );
    final failure = s.isEditing
        ? (await ref.read(updateRecurringRuleProvider)(
            s.editingId!,
            input,
          )).failureOrNull
        : (await ref.read(createRecurringRuleProvider)(input)).failureOrNull;
    if (failure == null) {
      await ref.read(recurringGenerationProvider.notifier).run();
    }
    if (!ref.mounted) return failure == null;
    _update((s) => s.copyWith(saving: false, failure: failure));
    return failure == null;
  }
}
