import 'package:expense_tracker/core/utils/clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_provider.g.dart';

@Riverpod(keepAlive: true)
Clock clock(Ref ref) => const SystemClock();
