import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/presentation/providers/categories_notifier.dart';
import 'package:expense_tracker/features/categories/presentation/widgets/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// 4-column picker of active categories of [type] (DESIGN §7.6): [firstId]
/// (the last used) leads, the selected one gets a primary ring, and the last
/// cell creates a new category.
class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({
    required this.type,
    required this.onSelected,
    this.selectedId,
    this.firstId,
    this.onCreateNew,
    this.shrinkWrap = false,
    super.key,
  });

  final CategoryType type;
  final String? selectedId;
  final String? firstId;
  final ValueChanged<Category> onSelected;
  final VoidCallback? onCreateNew;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider(type)).value ?? const [];
    final ordered = [
      ...categories.where((c) => c.id == firstId),
      ...categories.where((c) => c.id != firstId),
    ];
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final cellHeight =
        Dimens.iconCircle +
        Dimens.selectedRingWidth * 2 +
        Dimens.space1 * 3 +
        2 * 16 * textScale;

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: cellHeight,
        crossAxisSpacing: Dimens.space2,
        mainAxisSpacing: Dimens.space2,
      ),
      itemCount: ordered.length + (onCreateNew == null ? 0 : 1),
      itemBuilder: (context, i) => i < ordered.length
          ? _CategoryCell(
              category: ordered[i],
              selected: ordered[i].id == selectedId,
              onTap: () => onSelected(ordered[i]),
            )
          : _NewCell(onTap: onCreateNew!),
    );
  }
}

class _CategoryCell extends StatelessWidget {
  const _CategoryCell({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final Category category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = theme.textTheme.labelSmall!;
    return Semantics(
      button: true,
      selected: selected,
      label: category.name,
      excludeSemantics: true,
      child: InkWell(
        key: ValueKey('category-${category.id}'),
        borderRadius: BorderRadius.circular(Dimens.radiusSmall),
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: Dimens.space1),
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  width: Dimens.selectedRingWidth,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.selectedRingWidth),
                child: CategoryIcon(category),
              ),
            ),
            const SizedBox(height: Dimens.space1),
            Text(
              category.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: selected ? label.withWeight(FontWeight.w600) : label,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewCell extends StatelessWidget {
  const _NewCell({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return InkWell(
      key: const ValueKey('category-new'),
      borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: Dimens.space1 + Dimens.selectedRingWidth * 2),
          Container(
            width: Dimens.iconCircle,
            height: Dimens.iconCircle,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surfaceContainer,
            ),
            child: Icon(
              Symbols.add_rounded,
              size: Dimens.iconGlyph,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: Dimens.space1),
          Text(
            l10n.categories_new_short,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
