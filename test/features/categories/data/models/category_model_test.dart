import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/features/categories/data/models/category_model.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const input = CategoryInput(
    name: 'Coffee',
    type: CategoryType.expense,
    icon: 'local_cafe',
    color: PaletteColor.brown,
  );

  test('create payload has every column, keyed by column name', () {
    expect(input.toJson(), {
      'name': 'Coffee',
      'type': 'expense',
      'icon': 'local_cafe',
      'color': 'brown',
    });
  });

  test('update payload omits type (a category never changes type)', () {
    final json = input.toJson(forUpdate: true);
    expect(json.containsKey('type'), isFalse);
    expect(json, {'name': 'Coffee', 'icon': 'local_cafe', 'color': 'brown'});
  });
}
