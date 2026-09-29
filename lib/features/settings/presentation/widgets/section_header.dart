import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:flutter/material.dart';

/// A list section title (DESIGN §8.6).
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.screenPadding,
          Dimens.space6,
          Dimens.screenPadding,
          Dimens.space2,
        ),
        child: Text(
          title,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
