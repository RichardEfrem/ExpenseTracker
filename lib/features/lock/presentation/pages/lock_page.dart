import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:expense_tracker/features/lock/presentation/providers/pin_entry_notifiers.dart';
import 'package:expense_tracker/features/lock/presentation/widgets/lock_messages.dart';
import 'package:expense_tracker/features/lock/presentation/widgets/pin_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Full-screen unlock (DESIGN §8.11): PIN dots over the digits-only keypad;
/// the biometric prompt shows by itself when that unlock is on.
class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});

  @override
  ConsumerState<LockPage> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    // Again whenever the app comes back to the screen; a dismissed prompt
    // doesn't hide the app, so cancelling doesn't loop.
    _lifecycle = AppLifecycleListener(onShow: _promptBiometric);
    WidgetsBinding.instance.addPostFrameCallback((_) => _promptBiometric());
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  Future<void> _promptBiometric() async {
    if (!mounted) return;
    final lock = ref.read(appLockProvider).value;
    if (lock == null || !lock.isLocked || !lock.settings.biometric) return;
    await ref
        .read(appLockProvider.notifier)
        .unlockWithBiometric(
          AppLocalizations.of(context).lock_biometric_reason,
        );
  }

  Future<void> _forgot() => showDialog<void>(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return AlertDialog(
        title: Text(l10n.lock_forgot),
        content: Text(l10n.lock_forgot_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.common_close),
          ),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final settings = ref.watch(appLockProvider).value?.settings;
    final entry = ref.watch(lockScreenProvider);
    final notifier = ref.read(lockScreenProvider.notifier);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: PinScaffoldBody(
        header: [
          CircleAvatar(
            radius: 36,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(
              Symbols.lock_rounded,
              size: 36,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: Dimens.space4),
          Semantics(
            header: true,
            child: Text(l10n.lock_title, style: theme.textTheme.headlineSmall),
          ),
          const SizedBox(height: Dimens.space1),
          Text(l10n.lock_enter_pin, style: theme.textTheme.bodyMedium),
        ],
        dots: PinDots(
          filled: entry.digits.length,
          length: settings?.pinLength ?? 4,
        ),
        message: unlockMessage(
          l10n,
          ref.watch(clockProvider).now(),
          rejected: entry.rejected,
          failure: entry.failure,
        ),
        keypad: AmountKeypad(
          mode: KeypadMode.pin,
          onKey: notifier.onKey,
          pinLeading: settings?.biometric ?? false
              ? IconButton(
                  key: const ValueKey('biometric-unlock'),
                  tooltip: l10n.lock_biometric,
                  icon: const Icon(Symbols.fingerprint_rounded),
                  onPressed: _promptBiometric,
                )
              : null,
        ),
        footer: TextButton(onPressed: _forgot, child: Text(l10n.lock_forgot)),
      ),
    );
  }
}
