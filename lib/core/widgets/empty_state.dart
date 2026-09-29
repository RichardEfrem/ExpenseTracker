import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:flutter/material.dart';

/// Icon + one line + one button; no illustrations (DESIGN §7.10).
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Scrolls when it can't fit, e.g. at 200% font on a short screen.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimens.space6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: Dimens.emptyStateIcon,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: Dimens.space4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge,
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: Dimens.space4),
            FilledButton.tonal(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
