import 'package:expense_tracker/core/theme/category_icons.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:flutter/material.dart';

/// A category's icon circle; reads as the category name (DESIGN §9).
class CategoryIcon extends StatelessWidget {
  const CategoryIcon(this.category, {this.size, super.key});

  final Category category;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final color = FinanceColors.of(context).category(category.color);
    final icon = CategoryIcons.of(category.icon);
    return size == null
        ? IconCircle(icon: icon, color: color, semanticLabel: category.name)
        : IconCircle(
            icon: icon,
            color: color,
            size: size!,
            semanticLabel: category.name,
          );
  }
}
