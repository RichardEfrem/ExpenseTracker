import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/features/lock/data/datasources/device_security_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/lock_secure_datasource.dart';
import 'package:expense_tracker/features/lock/data/datasources/pin_hasher.dart';
import 'package:expense_tracker/features/lock/data/repositories/lock_repository_impl.dart';
import 'package:expense_tracker/features/lock/domain/repositories/lock_repository.dart';
import 'package:expense_tracker/features/lock/domain/usecases/biometric_unlock.dart';
import 'package:expense_tracker/features/lock/domain/usecases/lock_preferences.dart';
import 'package:expense_tracker/features/lock/domain/usecases/manage_pin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lock_providers.g.dart';

@riverpod
LockSecureDataSource lockSecureDataSource(Ref ref) =>
    const LockSecureDataSource(FlutterSecureStorage());

@riverpod
PinHasher pinHasher(Ref ref) => const PinHasher();

@riverpod
BiometricDataSource biometricDataSource(Ref ref) =>
    BiometricDataSource(LocalAuthentication());

@riverpod
SecureWindowDataSource secureWindowDataSource(Ref ref) =>
    const SecureWindowDataSource();

@riverpod
LockRepository lockRepository(Ref ref) => LockRepositoryImpl(
  ref.watch(lockSecureDataSourceProvider),
  ref.watch(pinHasherProvider),
  ref.watch(biometricDataSourceProvider),
  ref.watch(secureWindowDataSourceProvider),
);

@riverpod
GetLockSettings getLockSettings(Ref ref) =>
    GetLockSettings(ref.watch(lockRepositoryProvider));

@riverpod
SetPin setPin(Ref ref) => SetPin(ref.watch(lockRepositoryProvider));

@riverpod
VerifyPin verifyPin(Ref ref) =>
    VerifyPin(ref.watch(lockRepositoryProvider), ref.watch(clockProvider));

@riverpod
DisableLock disableLock(Ref ref) =>
    DisableLock(ref.watch(lockRepositoryProvider));

@riverpod
SetLockTimeout setLockTimeout(Ref ref) =>
    SetLockTimeout(ref.watch(lockRepositoryProvider));

@riverpod
SetBiometricUnlock setBiometricUnlock(Ref ref) =>
    SetBiometricUnlock(ref.watch(lockRepositoryProvider));

@riverpod
ApplySecureWindow applySecureWindow(Ref ref) =>
    ApplySecureWindow(ref.watch(lockRepositoryProvider));

@riverpod
CheckBiometricAvailable checkBiometricAvailable(Ref ref) =>
    CheckBiometricAvailable(ref.watch(lockRepositoryProvider));

@riverpod
AuthenticateBiometric authenticateBiometric(Ref ref) =>
    AuthenticateBiometric(ref.watch(lockRepositoryProvider));
