import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/lock/domain/entities/pin.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:expense_tracker/features/lock/presentation/providers/pin_entry_notifiers.dart';
import 'package:expense_tracker/features/lock/presentation/widgets/lock_messages.dart';
import 'package:expense_tracker/features/lock/presentation/widgets/pin_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Turn the lock on (choose + confirm), change the PIN (current + choose +
/// confirm) or turn it off (current).
class PinSetupPage extends ConsumerWidget {
  const PinSetupPage({required this.mode, super.key});

  final PinSetupMode mode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final provider = pinSetupProvider(mode);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final pinLength =
        ref.watch(appLockProvider).value?.settings.pinLength ?? Pin.minLength;

    ref.listen(provider.select((s) => s.step), (_, step) {
      if (step != PinSetupStep.done) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(switch (mode) {
              PinSetupMode.enable => l10n.lock_enabled,
              PinSetupMode.change => l10n.pin_changed,
              PinSetupMode.disable => l10n.lock_disabled,
            }),
          ),
        );
      Navigator.of(context).pop();
    });

    final (title, hint) = switch (state.step) {
      PinSetupStep.current => (l10n.pin_current, null),
      PinSetupStep.choose => (l10n.pin_new, l10n.pin_new_hint),
      _ => (l10n.pin_confirm, null),
    };
    final slots = switch (state.step) {
      PinSetupStep.current => pinLength,
      PinSetupStep.choose => Pin.maxLength,
      _ => state.chosen.length,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode == PinSetupMode.change ? l10n.lock_change_pin : l10n.lock_switch,
        ),
      ),
      body: PinScaffoldBody(
        header: [
          Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.headlineSmall),
          ),
          if (hint != null) ...[
            const SizedBox(height: Dimens.space1),
            Text(hint, style: theme.textTheme.bodyMedium),
          ],
        ],
        dots: PinDots(filled: state.digits.length, length: slots),
        message: state.mismatch
            ? l10n.pin_mismatch
            : unlockMessage(
                l10n,
                ref.watch(clockProvider).now(),
                rejected: state.rejected,
                failure: state.failure,
              ),
        keypad: AmountKeypad(mode: KeypadMode.pin, onKey: notifier.onKey),
        footer: state.step == PinSetupStep.choose
            ? Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.screenPadding,
                  Dimens.space3,
                  Dimens.screenPadding,
                  0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: Dimens.primaryButtonHeight,
                  child: FilledButton(
                    key: const ValueKey('pin-continue'),
                    onPressed: state.canContinue ? notifier.submitChosen : null,
                    child: Text(l10n.pin_continue),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
