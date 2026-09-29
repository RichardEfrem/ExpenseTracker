import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:flutter/material.dart';

/// A chart card: `titleMedium` title with an optional trailing control,
/// then the chart (DESIGN §7.9).
class ReportCard extends StatelessWidget {
  const ReportCard({
    required this.title,
    required this.child,
    this.trailing,
    super.key,
  });

  final String title;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: Dimens.space2,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                ?trailing,
              ],
            ),
            const SizedBox(height: Dimens.space4),
            child,
          ],
        ),
      ),
    );
  }
}
