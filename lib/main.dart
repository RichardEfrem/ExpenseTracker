import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/features/lock/lock_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // Know whether the app is locked before the first frame, so its content
  // never flashes before the lock screen (PRD §6.4).
  await container.read(appLockProvider.future);
  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
