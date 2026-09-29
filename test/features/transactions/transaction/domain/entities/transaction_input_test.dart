import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:flutter_test/flutter_test.dart';

final base = TransactionInput(
  type: TransactionType.expense,
  amount: 45000,
  accountId: 'cash',
  categoryId: 'food',
  date: LocalDate(2026, 9, 29),
  time: const LocalTime(12, 30),
);

ValidationReason? reasonOf(TransactionInput input) =>
    input.validated().getLeft().toNullable();

void main() {
  test('valid input passes', () => expect(reasonOf(base), isNull));

  test('amount must be positive and storable', () {
    expect(
      reasonOf(base.copyWith(amount: 0)),
      ValidationReason.amountNotPositive,
    );
    expect(
      reasonOf(base.copyWith(amount: -5)),
      ValidationReason.amountNotPositive,
    );
    expect(
      reasonOf(base.copyWith(amount: TransactionInput.maxAmount + 1)),
      ValidationReason.amountTooLarge,
    );
  });

  test('note ≤ 200 characters after trimming; blank becomes null', () {
    expect(reasonOf(base.copyWith(note: 'x' * 200)), isNull);
    expect(
      reasonOf(base.copyWith(note: 'x' * 201)),
      ValidationReason.noteTooLong,
    );
    expect(reasonOf(base.copyWith(note: '  ${'x' * 200}  ')), isNull);
    expect(base.copyWith(note: '   ').validated().toNullable()!.note, isNull);
    expect(
      base.copyWith(note: ' Lunch ').validated().toNullable()!.note,
      'Lunch',
    );
  });

  test('income and expense need a category', () {
    expect(
      reasonOf(base.copyWith(categoryId: null)),
      ValidationReason.categoryRequired,
    );
    expect(
      reasonOf(base.copyWith(type: TransactionType.income, categoryId: null)),
      ValidationReason.categoryRequired,
    );
  });

  test('transfers need two different accounts and drop the category', () {
    final transfer = base.copyWith(type: TransactionType.transfer);
    expect(reasonOf(transfer), ValidationReason.accountRequired);
    expect(
      reasonOf(transfer.copyWith(toAccountId: 'cash')),
      ValidationReason.sameAccount,
    );
    final valid = transfer
        .copyWith(toAccountId: 'bank')
        .validated()
        .toNullable()!;
    expect(valid.categoryId, isNull);
  });

  test('non-transfers drop a stray destination account', () {
    expect(
      base.copyWith(toAccountId: 'bank').validated().toNullable()!.toAccountId,
      isNull,
    );
  });
}
