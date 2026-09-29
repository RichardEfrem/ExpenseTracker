import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/transactions/transaction/data/transaction_providers.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/add_transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/get_last_used.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/transaction_form_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetLastUsed extends Mock implements GetLastUsed {}

class _MockAdd extends Mock implements AddTransaction {}

Category category(String id, CategoryType type) => Category(
  id: id,
  name: id,
  type: type,
  icon: 'restaurant',
  color: PaletteColor.orange,
  isArchived: false,
  sortOrder: 0,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
);

final cash = Account(
  id: 'cash',
  name: 'Cash',
  type: AccountType.cash,
  icon: 'payments',
  color: PaletteColor.emerald,
  openingBalance: 0,
  isArchived: false,
  sortOrder: 0,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
);

void main() {
  late _MockGetLastUsed getLastUsed;
  late _MockAdd add;
  late ProviderContainer container;

  setUpAll(() {
    registerFallbackValue(TransactionType.expense);
    registerFallbackValue(
      TransactionInput(
        type: TransactionType.expense,
        amount: 1,
        accountId: '',
        date: LocalDate(2026, 1, 1),
        time: const LocalTime(0, 0),
      ),
    );
  });

  setUp(() {
    getLastUsed = _MockGetLastUsed();
    when(
      () => getLastUsed(any()),
    ).thenAnswer((_) async => const Right(LastUsed()));
    add = _MockAdd();
    when(
      () => getLastUsed(TransactionType.expense),
    ).thenAnswer((_) async => const Right(LastUsed(categoryId: 'groceries')));
    when(
      () => getLastUsed(TransactionType.income),
    ).thenAnswer((_) async => const Right(LastUsed(categoryId: 'archived')));
    container = ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(
          FixedClock(DateTime(2026, 9, 29, 12, 30)),
        ),
        getLastUsedProvider.overrideWithValue(getLastUsed),
        addTransactionProvider.overrideWithValue(add),
        defaultAccountProvider.overrideWith(() => _FixedDefault()),
        accountsProvider().overrideWith(() => _FixedAccounts()),
        categoriesProvider(CategoryType.expense).overrideWith(
          () => _FixedCategories([
            category('food', CategoryType.expense),
            category('groceries', CategoryType.expense),
          ]),
        ),
        categoriesProvider(CategoryType.income).overrideWith(
          () => _FixedCategories([category('salary', CategoryType.income)]),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  final provider = transactionFormProvider(TransactionType.expense);

  Future<TransactionFormNotifier> ready() async {
    container.listen(provider, (_, _) {});
    await container.read(provider.future);
    return container.read(provider.notifier);
  }

  test('starts with the last-used category, default account, now', () async {
    await ready();
    final state = container.read(provider).value!;
    expect(state.categoryId, 'groceries');
    expect(state.firstCategoryId, 'groceries');
    expect(state.accountId, 'cash');
    expect(state.date, LocalDate(2026, 9, 29));
    expect(state.time, const LocalTime(12, 30));
    expect(state.canSave, isFalse);
  });

  test('switching type uses that type\'s last used, falling back to the first '
      'active one', () async {
    final notifier = await ready();
    notifier.setType(TransactionType.income);
    expect(container.read(provider).value!.categoryId, 'salary');
    notifier.setType(TransactionType.expense);
    expect(container.read(provider).value!.categoryId, 'groceries');
  });

  test('keypad input evaluates the expression live', () async {
    final notifier = await ready();
    for (final key in [
      KeypadKey.digit(2),
      KeypadKey.digit(5),
      KeypadKey.tripleZero,
      KeypadKey.add,
      KeypadKey.digit(5),
      KeypadKey.tripleZero,
    ]) {
      notifier.onKey(key);
    }
    final state = container.read(provider).value!;
    expect(state.expression, '25000+5000');
    expect(state.amount, 30000);
    expect(state.canSave, isTrue);
  });

  test('save sends the input to AddTransaction', () async {
    final notifier = await ready();
    when(
      () => add(any()),
    ).thenAnswer((_) async => const Left(Failure.unexpected()));
    notifier
      ..onKey(KeypadKey.digit(9))
      ..setNote('  ');
    expect(await notifier.save(), isFalse);
    expect(container.read(provider).value!.failure, isA<UnexpectedFailure>());
    final input =
        verify(() => add(captureAny())).captured.single as TransactionInput;
    expect(input.amount, 9);
    expect(input.categoryId, 'groceries');
    expect(input.note, isNull);
  });
}

class _FixedDefault extends DefaultAccountNotifier {
  @override
  Future<Account> build() async => cash;
}

class _FixedAccounts extends AccountsNotifier {
  @override
  Stream<List<Account>> build({bool includeArchived = false}) =>
      Stream.value([cash]);
}

class _FixedCategories extends CategoriesNotifier {
  _FixedCategories(this.items);

  final List<Category> items;

  @override
  Stream<List<Category>> build(
    CategoryType type, {
    bool includeArchived = false,
  }) => Stream.value(items);
}
