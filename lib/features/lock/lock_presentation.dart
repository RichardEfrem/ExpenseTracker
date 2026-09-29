// Public presentation API of the lock module: only `export … show …` lines.
export 'package:expense_tracker/features/lock/domain/entities/lock_settings.dart'
    show LockSettings, LockTimeout;
export 'package:expense_tracker/features/lock/presentation/providers/app_lock_notifier.dart'
    show AppLockNotifier, appLockProvider, AppLockState, LockStatus;
