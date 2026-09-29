import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

/// A key press from [AmountKeypad].
enum KeypadKey {
  digit0,
  digit1,
  digit2,
  digit3,
  digit4,
  digit5,
  digit6,
  digit7,
  digit8,
  digit9,
  tripleZero,
  backspace,

  /// Long-press on backspace.
  clear,
  add,
  subtract,
  multiply,
  divide;

  static KeypadKey digit(int n) => values[n];

  /// 0–9 for digit keys, else null.
  int? get digitValue => index <= 9 ? index : null;

  bool get isOperator => index >= add.index;
}

enum KeypadMode {
  /// 4×4 calculator layout with operators and `000` (DESIGN §7.5).
  amount,

  /// 3×4 phone layout, digits only (DESIGN §8.11).
  pin,
}

/// Custom keypad for amounts (with arithmetic) and PINs. Emits [KeypadKey]s;
/// the caller owns the text.
class AmountKeypad extends StatelessWidget {
  const AmountKeypad({
    required this.onKey,
    this.mode = KeypadMode.amount,
    this.pinLeading,
    super.key,
  });

  final ValueChanged<KeypadKey> onKey;
  final KeypadMode mode;

  /// Widget in the bottom-left PIN cell (e.g. a biometric button).
  final Widget? pinLeading;

  @override
  Widget build(BuildContext context) {
    final rows = switch (mode) {
      KeypadMode.amount => const [
        [
          KeypadKey.digit7,
          KeypadKey.digit8,
          KeypadKey.digit9,
          KeypadKey.divide,
        ],
        [
          KeypadKey.digit4,
          KeypadKey.digit5,
          KeypadKey.digit6,
          KeypadKey.multiply,
        ],
        [
          KeypadKey.digit1,
          KeypadKey.digit2,
          KeypadKey.digit3,
          KeypadKey.subtract,
        ],
        [
          KeypadKey.tripleZero,
          KeypadKey.digit0,
          KeypadKey.backspace,
          KeypadKey.add,
        ],
      ],
      KeypadMode.pin => const [
        [KeypadKey.digit1, KeypadKey.digit2, KeypadKey.digit3],
        [KeypadKey.digit4, KeypadKey.digit5, KeypadKey.digit6],
        [KeypadKey.digit7, KeypadKey.digit8, KeypadKey.digit9],
        [null, KeypadKey.digit0, KeypadKey.backspace],
      ],
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (i, row) in rows.indexed) ...[
          if (i > 0) const SizedBox(height: Dimens.keypadGap),
          Row(
            children: [
              for (final (j, key) in row.indexed) ...[
                if (j > 0) const SizedBox(width: Dimens.keypadGap),
                Expanded(
                  child: key == null
                      ? SizedBox(
                          height: Dimens.keypadKeyHeight,
                          child: Center(child: pinLeading),
                        )
                      : _Key(keypadKey: key, onKey: onKey),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({required this.keypadKey, required this.onKey});

  final KeypadKey keypadKey;
  final ValueChanged<KeypadKey> onKey;

  void _emit(KeypadKey key) {
    HapticFeedback.selectionClick();
    onKey(key);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colors = theme.colorScheme;
    final digitStyle = theme.textTheme.headlineSmall!.tabular;
    final operatorStyle = digitStyle.copyWith(color: colors.onSurfaceVariant);

    final (Widget face, String? label) = switch (keypadKey) {
      KeypadKey.backspace => (
        Icon(Symbols.backspace_rounded, color: colors.onSurfaceVariant),
        l10n.keypad_delete,
      ),
      KeypadKey.tripleZero => (
        Text('000', style: digitStyle),
        l10n.keypad_triple_zero,
      ),
      KeypadKey.add => (Text('+', style: operatorStyle), l10n.keypad_plus),
      KeypadKey.subtract => (
        Text('−', style: operatorStyle),
        l10n.keypad_minus,
      ),
      KeypadKey.multiply => (
        Text('×', style: operatorStyle),
        l10n.keypad_times,
      ),
      KeypadKey.divide => (Text('÷', style: operatorStyle), l10n.keypad_divide),
      _ => (Text('${keypadKey.digitValue}', style: digitStyle), null),
    };
    final isBackspace = keypadKey == KeypadKey.backspace;

    return Semantics(
      button: true,
      label: label,
      onLongPressHint: isBackspace ? l10n.keypad_clear : null,
      excludeSemantics: label != null,
      child: Material(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(Dimens.radiusSmall),
        child: InkWell(
          key: ValueKey(keypadKey),
          borderRadius: BorderRadius.circular(Dimens.radiusSmall),
          onTap: () => _emit(keypadKey),
          onLongPress: isBackspace ? () => _emit(KeypadKey.clear) : null,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: Dimens.keypadKeyHeight,
            ),
            child: Center(child: face),
          ),
        ),
      ),
    );
  }
}
