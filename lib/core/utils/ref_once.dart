import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

extension RefOnce on Ref {
  /// The first loaded value of [provider], without rebuilding when it
  /// changes later. For a Notifier build that must not reset user input
  /// when, say, the category list updates. Keeps [provider] alive while
  /// waiting.
  Future<T> once<T>(ProviderListenable<AsyncValue<T>> provider) {
    final completer = Completer<T>();
    late final ProviderSubscription<AsyncValue<T>> sub;
    sub = listen<AsyncValue<T>>(provider, (_, next) {
      if (completer.isCompleted) return;
      switch (next) {
        case AsyncData(:final value):
          completer.complete(value);
        case AsyncError(:final error, :final stackTrace):
          completer.completeError(error, stackTrace);
        default:
          return;
      }
      // Deferred: with fireImmediately this runs before `sub` is assigned.
      scheduleMicrotask(() => sub.close());
    }, fireImmediately: true);
    return completer.future;
  }
}
