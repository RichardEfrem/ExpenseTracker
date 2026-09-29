// Public presentation API of the categories module: only `export … show …`
// lines.
export 'package:expense_tracker/features/categories/domain/entities/category.dart'
    show Category, CategoryType;
export 'package:expense_tracker/features/categories/presentation/providers/categories_notifier.dart'
    show CategoriesNotifier, categoriesProvider;
export 'package:expense_tracker/features/categories/presentation/widgets/category_edit_sheet.dart'
    show showCategoryEditSheet;
export 'package:expense_tracker/features/categories/presentation/widgets/category_grid.dart'
    show CategoryGrid;
export 'package:expense_tracker/features/categories/presentation/widgets/category_icon.dart'
    show CategoryIcon;
