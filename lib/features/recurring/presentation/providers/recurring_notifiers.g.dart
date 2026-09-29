// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every rule with its category and accounts, soonest next date first.

@ProviderFor(RecurringRulesNotifier)
final recurringRulesProvider = RecurringRulesNotifierProvider._();

/// Every rule with its category and accounts, soonest next date first.
final class RecurringRulesNotifierProvider
    extends $StreamNotifierProvider<RecurringRulesNotifier, List<RuleView>> {
  /// Every rule with its category and accounts, soonest next date first.
  RecurringRulesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringRulesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringRulesNotifierHash();

  @$internal
  @override
  RecurringRulesNotifier create() => RecurringRulesNotifier();
}

String _$recurringRulesNotifierHash() =>
    r'b3304d8fb3e65defd60aa25f073bd10ade702d96';

/// Every rule with its category and accounts, soonest next date first.

abstract class _$RecurringRulesNotifier
    extends $StreamNotifier<List<RuleView>> {
  Stream<List<RuleView>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<RuleView>>, List<RuleView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RuleView>>, List<RuleView>>,
              AsyncValue<List<RuleView>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Due occurrences waiting for confirm or skip, oldest first (PRD REC-03).

@ProviderFor(PendingOccurrencesNotifier)
final pendingOccurrencesProvider = PendingOccurrencesNotifierProvider._();

/// Due occurrences waiting for confirm or skip, oldest first (PRD REC-03).
final class PendingOccurrencesNotifierProvider
    extends
        $StreamNotifierProvider<PendingOccurrencesNotifier, List<PendingView>> {
  /// Due occurrences waiting for confirm or skip, oldest first (PRD REC-03).
  PendingOccurrencesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingOccurrencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingOccurrencesNotifierHash();

  @$internal
  @override
  PendingOccurrencesNotifier create() => PendingOccurrencesNotifier();
}

String _$pendingOccurrencesNotifierHash() =>
    r'ec850d65a2cfe6ce84aa65ef9c0e9e63cdb93aaa';

/// Due occurrences waiting for confirm or skip, oldest first (PRD REC-03).

abstract class _$PendingOccurrencesNotifier
    extends $StreamNotifier<List<PendingView>> {
  Stream<List<PendingView>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PendingView>>, List<PendingView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PendingView>>, List<PendingView>>,
              AsyncValue<List<PendingView>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Creates or queues every occurrence due up to today (PRD REC-02). Runs
/// when the app first listens (app open) and again on [run]: on resume and
/// after a rule is saved. Idempotent, so overlapping runs are harmless.

@ProviderFor(RecurringGeneration)
final recurringGenerationProvider = RecurringGenerationProvider._();

/// Creates or queues every occurrence due up to today (PRD REC-02). Runs
/// when the app first listens (app open) and again on [run]: on resume and
/// after a rule is saved. Idempotent, so overlapping runs are harmless.
final class RecurringGenerationProvider
    extends $AsyncNotifierProvider<RecurringGeneration, GenerationResult> {
  /// Creates or queues every occurrence due up to today (PRD REC-02). Runs
  /// when the app first listens (app open) and again on [run]: on resume and
  /// after a rule is saved. Idempotent, so overlapping runs are harmless.
  RecurringGenerationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringGenerationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringGenerationHash();

  @$internal
  @override
  RecurringGeneration create() => RecurringGeneration();
}

String _$recurringGenerationHash() =>
    r'770821b3aa2d0687c18b821908f4792ab33409c8';

/// Creates or queues every occurrence due up to today (PRD REC-02). Runs
/// when the app first listens (app open) and again on [run]: on resume and
/// after a rule is saved. Idempotent, so overlapping runs are harmless.

abstract class _$RecurringGeneration extends $AsyncNotifier<GenerationResult> {
  FutureOr<GenerationResult> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<GenerationResult>, GenerationResult>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GenerationResult>, GenerationResult>,
              AsyncValue<GenerationResult>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Rule and pending writes; each returns its failure (or null) for the UI
/// to show. Watched lists update themselves.

@ProviderFor(RecurringActions)
final recurringActionsProvider = RecurringActionsProvider._();

/// Rule and pending writes; each returns its failure (or null) for the UI
/// to show. Watched lists update themselves.
final class RecurringActionsProvider
    extends $NotifierProvider<RecurringActions, void> {
  /// Rule and pending writes; each returns its failure (or null) for the UI
  /// to show. Watched lists update themselves.
  RecurringActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringActionsHash();

  @$internal
  @override
  RecurringActions create() => RecurringActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$recurringActionsHash() => r'b37f5560c1f5e7de24c6d505855e8d9140a4855b';

/// Rule and pending writes; each returns its failure (or null) for the UI
/// to show. Watched lists update themselves.

abstract class _$RecurringActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
