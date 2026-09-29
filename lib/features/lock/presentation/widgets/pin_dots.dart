import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

/// One dot per PIN digit, [filled] of them solid (DESIGN §8.11). Read as
/// "2 of 4 digits entered", never the digits.
class PinDots extends StatelessWidget {
  const PinDots({required this.filled, required this.length, super.key});

  final int filled;
  final int length;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      label: AppLocalizations.of(context).lock_pin_progress(filled, length),
      child: ExcludeSemantics(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < length; i++)
              Container(
                width: 14,
                height: 14,
                margin: const EdgeInsets.symmetric(horizontal: Dimens.space2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < filled ? colors.primary : Colors.transparent,
                  border: Border.all(color: colors.outline, width: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A PIN screen body: title and hint on top, dots and a message line, the
/// digits-only keypad at the bottom. Scrolls above the keypad at large
/// font sizes.
class PinScaffoldBody extends StatelessWidget {
  const PinScaffoldBody({
    required this.header,
    required this.dots,
    required this.message,
    required this.keypad,
    this.footer,
    super.key,
  });

  final List<Widget> header;
  final Widget dots;

  /// Error or hint under the dots; null keeps the space.
  final String? message;
  final Widget keypad;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Dimens.screenPadding),
                child: Column(
                  children: [
                    ...header,
                    const SizedBox(height: Dimens.space6),
                    dots,
                    const SizedBox(height: Dimens.space3),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        message ?? '',
                        key: const ValueKey('pin-message'),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.screenPadding,
            ),
            child: keypad,
          ),
          ?footer,
          const SizedBox(height: Dimens.space2),
        ],
      ),
    );
  }
}
