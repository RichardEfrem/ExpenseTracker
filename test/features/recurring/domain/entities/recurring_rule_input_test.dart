import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final rent = RecurringRuleInput(
    type: TransactionType.expense,
    amount: 3000000,
    accountId: 'cash',
    categoryId: 'housing',
    note: '  Rent ',
    frequency: RecurrenceFrequency.monthly,
    startDate: LocalDate(2026, 9, 25),
  );

  ValidationReason? reasonOf(RecurringRuleInput input) =>
      input.validated().getLeft().toNullable();

  test('valid monthly rule: note trimmed, day of month from the start', () {
    final valid = rent.validated().getOrElse((r) => fail('$r'));
    expect(valid.note, 'Rent');
    expect(valid.dayOfMonth, 25);
    expect(valid.autoCreate, isTrue);
    expect(valid.interval, 1);
  });

  test('an explicit day of month is kept', () {
    expect(
      rent.copyWith(dayOfMonth: 31).validated().toNullable()!.dayOfMonth,
      31,
    );
  });

  test('day of month is dropped for other frequencies', () {
    expect(
      rent
          .copyWith(frequency: RecurrenceFrequency.weekly, dayOfMonth: 3)
          .validated()
          .toNullable()!
          .dayOfMonth,
      isNull,
    );
  });

  test('interval must be 1–365', () {
    expect(
      reasonOf(rent.copyWith(interval: 0)),
      ValidationReason.intervalOutOfRange,
    );
    expect(
      reasonOf(rent.copyWith(interval: 366)),
      ValidationReason.intervalOutOfRange,
    );
    expect(reasonOf(rent.copyWith(interval: 365)), isNull);
  });

  test('day of month must be 1–31', () {
    expect(
      reasonOf(rent.copyWith(dayOfMonth: 0)),
      ValidationReason.dayOfMonthOutOfRange,
    );
    expect(
      reasonOf(rent.copyWith(dayOfMonth: 32)),
      ValidationReason.dayOfMonthOutOfRange,
    );
  });

  test('end before start is rejected; same day is fine', () {
    expect(
      reasonOf(rent.copyWith(endDate: LocalDate(2026, 9, 24))),
      ValidationReason.endBeforeStart,
    );
    expect(reasonOf(rent.copyWith(endDate: LocalDate(2026, 9, 25))), isNull);
  });

  test('template rules follow transaction validation', () {
    expect(
      reasonOf(rent.copyWith(amount: 0)),
      ValidationReason.amountNotPositive,
    );
    expect(
      reasonOf(rent.copyWith(categoryId: null)),
      ValidationReason.categoryRequired,
    );
    expect(
      reasonOf(
        rent.copyWith(type: TransactionType.transfer, toAccountId: 'cash'),
      ),
      ValidationReason.sameAccount,
    );
  });

  test('a transfer rule drops its category', () {
    final valid = rent
        .copyWith(type: TransactionType.transfer, toAccountId: 'bank')
        .validated()
        .toNullable()!;
    expect(valid.categoryId, isNull);
    expect(valid.toAccountId, 'bank');
  });

  test('adjustments cannot repeat', () {
    expect(
      reasonOf(rent.copyWith(type: TransactionType.adjustment)),
      ValidationReason.invalidInput,
    );
  });

  test('the template is the transaction on the given date', () {
    final t = rent.templateInput(LocalDate(2026, 10, 25));
    expect(t.date, LocalDate(2026, 10, 25));
    expect(
      (t.type, t.amount, t.accountId, t.categoryId),
      (TransactionType.expense, 3000000, 'cash', 'housing'),
    );
  });
}
