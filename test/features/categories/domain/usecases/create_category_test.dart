import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:expense_tracker/features/categories/domain/repositories/category_repository.dart';
import 'package:expense_tracker/features/categories/domain/usecases/create_category.dart';
import 'package:expense_tracker/features/categories/domain/usecases/merge_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements CategoryRepository {}

void main() {
  late _MockRepository repo;

  setUpAll(() {
    registerFallbackValue(
      const CategoryInput(
        name: '',
        type: CategoryType.expense,
        icon: '',
        color: PaletteColor.neutral,
      ),
    );
  });
  setUp(() => repo = _MockRepository());

  CategoryInput named(String name) => CategoryInput(
    name: name,
    type: CategoryType.expense,
    icon: 'restaurant',
    color: PaletteColor.orange,
  );

  test('blank name is rejected without touching the repository', () async {
    final result = await CreateCategory(repo)(named('   '));
    expect(
      result.getLeft().toNullable(),
      const Failure.validation(ValidationReason.nameEmpty),
    );
    verifyNever(() => repo.create(any()));
  });

  test('name over 40 characters is rejected', () async {
    final result = await CreateCategory(repo)(named('x' * 41));
    expect(
      result.getLeft().toNullable(),
      const Failure.validation(ValidationReason.nameTooLong),
    );
  });

  test('name is trimmed before saving', () async {
    final saved = Category(
      id: '1',
      name: 'Coffee',
      type: CategoryType.expense,
      icon: 'restaurant',
      color: PaletteColor.orange,
      isArchived: false,
      sortOrder: 0,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );
    when(() => repo.create(any())).thenAnswer((_) async => Right(saved));
    await CreateCategory(repo)(named('  Coffee '));
    expect(
      verify(() => repo.create(captureAny())).captured.single,
      named('Coffee'),
    );
  });

  test('merging a category into itself is rejected', () async {
    final result = await MergeCategory(repo)(fromId: 'a', intoId: 'a');
    expect(
      result.getLeft().toNullable(),
      const Failure.validation(ValidationReason.mergeIntoSelf),
    );
  });
}
