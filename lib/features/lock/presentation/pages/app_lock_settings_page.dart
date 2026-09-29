import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/widgets/choice_dialog.dart';
import 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart';
import 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart';
import 'package:expense_tracker/features/lock/presentation/providers/pin_entry_notifiers.dart';
import 'package:expense_tracker/features/lock/presentation/widgets/lock_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// App lock settings (PRD §4.6, §6.4): PIN on/off, change PIN, biometric
/// unlock, and how long away before it locks again.
class AppLockSettingsPage extends ConsumerWidget {
  const AppLockSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings =
        ref.watch(appLockProvider).value?.settings ?? const LockSettings();
    final biometricAvailable =
        ref.watch(biometricAvailabilityProvider).value ?? false;
    final lock = ref.read(appLockProvider.notifier);

    void open(PinSetupMode mode) =>
        context.push(AppPaths.pinSetupFor(mode.name));

    Future<void> apply(Future<Failure?> write) async {
      final messenger = ScaffoldMessenger.of(context);
      final failure = await write;
      if (failure != null) {
        messenger.showSnackBar(
          SnackBar(content: Text(failureMessage(l10n, failure))),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.more_app_lock)),
      body: ListView(
        children: [
          SwitchListTile(
            key: const ValueKey('lock-switch'),
            title: Text(l10n.lock_switch),
            subtitle: Text(l10n.lock_switch_hint),
            value: settings.enabled,
            onChanged: (on) =>
                open(on ? PinSetupMode.enable : PinSetupMode.disable),
          ),
          if (settings.enabled) ...[
            ListTile(
              key: const ValueKey('lock-change-pin'),
              title: Text(l10n.lock_change_pin),
              onTap: () => open(PinSetupMode.change),
            ),
            SwitchListTile(
              key: const ValueKey('lock-biometric'),
              title: Text(l10n.lock_biometric_switch),
              subtitle: biometricAvailable
                  ? null
                  : Text(l10n.lock_biometric_unavailable),
              value: settings.biometric && biometricAvailable,
              onChanged: biometricAvailable
                  ? (on) => apply(lock.setBiometric(enabled: on))
                  : null,
            ),
            ListTile(
              key: const ValueKey('lock-timeout'),
              title: Text(l10n.lock_timeout),
              subtitle: Text(lockTimeoutLabel(l10n, settings.timeout)),
              onTap: () async {
                final picked = await showChoiceDialog(
                  context,
                  title: l10n.lock_timeout,
                  values: LockTimeout.values,
                  current: settings.timeout,
                  label: (t) => lockTimeoutLabel(l10n, t),
                );
                if (picked != null) await apply(lock.setTimeout(picked));
              },
            ),
          ],
        ],
      ),
    );
  }
}
