import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/utils/ref_once.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/transactions/transaction/data/transaction_providers.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/transaction_form_state.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/keypad_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_form_notifier.g.dart';

CategoryType? categoryTypeOf(TransactionType type) => switch (type) {
  TransactionType.expense => CategoryType.expense,
  TransactionType.income => CategoryType.income,
  _ => null,
};

/// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
/// date, note; remembers the last-used category per type.
@riverpod
class TransactionFormNotifier extends _$TransactionFormNotifier {
  final _lastCategory = <TransactionType, String?>{};

  /// Active account ids, for picking a transfer destination.
  var _accounts = <String>[];

  String? _otherAccount(String accountId) =>
      _accounts.where((id) => id != accountId).firstOrNull;

  @override
  Future<TransactionFormState> build(
    TransactionType initialType, {
    String? editId,
  }) async {
    final now = ref.read(clockProvider).now();
    final defaultAccount = await ref.once(defaultAccountProvider);
    String? lastAccount;
    for (final type in TransactionType.values) {
      final last = (await ref.read(getLastUsedProvider)(type)).getOrThrow();
      if (type == initialType) lastAccount = last.accountId;
      final categoryType = categoryTypeOf(type);
      if (categoryType == null) continue;
      final active = await ref.once(categoriesProvider(categoryType));
      // Last used if still active, else the first in order (fresh install:
      // Food & Drinks), so amount → Save is enough (PRD TX-04).
      _lastCategory[type] = active.any((c) => c.id == last.categoryId)
          ? last.categoryId
          : active.firstOrNull?.id;
    }
    final accounts = await ref.once(accountsProvider());
    _accounts = [for (final a in accounts) a.id];

    if (editId != null) {
      final t = (await ref.read(getTransactionProvider)(editId)).getOrThrow();
      return TransactionFormState(
        editingId: t.id,
        type: t.type,
        expression: '${t.amount}',
        amount: t.amount,
        categoryId: t.categoryId,
        firstCategoryId: t.categoryId,
        accountId: t.accountId,
        toAccountId: t.toAccountId,
        date: t.date,
        time: t.time,
        note: t.note,
        tags: t.tags,
      );
    }
    final accountId = accounts.any((a) => a.id == lastAccount)
        ? lastAccount!
        : defaultAccount.id;
    return TransactionFormState(
      type: initialType,
      categoryId: _lastCategory[initialType],
      firstCategoryId: _lastCategory[initialType],
      accountId: accountId,
      toAccountId: initialType == TransactionType.transfer
          ? _otherAccount(accountId)
          : null,
      date: LocalDate.fromDateTime(now),
      time: LocalTime.fromDateTime(now),
    );
  }

  void _update(TransactionFormState Function(TransactionFormState) change) {
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
            categoryId: _lastCategory[type],
            firstCategoryId: _lastCategory[type],
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

  void setDate(LocalDate date) => _update((s) => s.copyWith(date: date));

  void setNote(String? note) => _update(
    (s) => s.copyWith(note: note == null || note.trim().isEmpty ? null : note),
  );

  void setTags(List<String> tags) => _update((s) => s.copyWith(tags: tags));

  /// Saves; true on success. A failure is kept in the state for display.
  Future<bool> save() async {
    final s = state.value;
    if (s == null || !s.canSave) return false;
    _update((s) => s.copyWith(saving: true, failure: null));
    final input = TransactionInput(
      type: s.type,
      amount: s.amount!,
      accountId: s.accountId,
      toAccountId: s.toAccountId,
      categoryId: s.categoryId,
      date: s.date,
      time: s.time,
      note: s.note,
      tags: s.tags,
    );
    final failure = s.isEditing
        ? (await ref.read(updateTransactionProvider)(
            s.editingId!,
            input,
          )).failureOrNull
        : (await ref.read(addTransactionProvider)(input)).failureOrNull;
    if (!ref.mounted) return failure == null;
    _update((s) => s.copyWith(saving: false, failure: failure));
    return failure == null;
  }
}
