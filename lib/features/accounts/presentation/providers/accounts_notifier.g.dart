// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Accounts in sort order (active only unless [includeArchived]).

@ProviderFor(AccountsNotifier)
final accountsProvider = AccountsNotifierFamily._();

/// Accounts in sort order (active only unless [includeArchived]).
final class AccountsNotifierProvider
    extends $StreamNotifierProvider<AccountsNotifier, List<Account>> {
  /// Accounts in sort order (active only unless [includeArchived]).
  AccountsNotifierProvider._({
    required AccountsNotifierFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'accountsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accountsNotifierHash();

  @override
  String toString() {
    return r'accountsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AccountsNotifier create() => AccountsNotifier();

  @override
  bool operator ==(Object other) {
    return other is AccountsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accountsNotifierHash() => r'508451ade86c55948c835cf00f0474268baf6c3b';

/// Accounts in sort order (active only unless [includeArchived]).

final class AccountsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          AccountsNotifier,
          AsyncValue<List<Account>>,
          List<Account>,
          Stream<List<Account>>,
          bool
        > {
  AccountsNotifierFamily._()
    : super(
        retry: null,
        name: r'accountsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Accounts in sort order (active only unless [includeArchived]).

  AccountsNotifierProvider call({bool includeArchived = false}) =>
      AccountsNotifierProvider._(argument: includeArchived, from: this);

  @override
  String toString() => r'accountsProvider';
}

/// Accounts in sort order (active only unless [includeArchived]).

abstract class _$AccountsNotifier extends $StreamNotifier<List<Account>> {
  late final _$args = ref.$arg as bool;
  bool get includeArchived => _$args;

  Stream<List<Account>> build({bool includeArchived = false});
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Account>>, List<Account>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Account>>, List<Account>>,
              AsyncValue<List<Account>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(includeArchived: _$args));
  }
}

/// The account preselected for new transactions.

@ProviderFor(DefaultAccountNotifier)
final defaultAccountProvider = DefaultAccountNotifierProvider._();

/// The account preselected for new transactions.
final class DefaultAccountNotifierProvider
    extends $AsyncNotifierProvider<DefaultAccountNotifier, Account> {
  /// The account preselected for new transactions.
  DefaultAccountNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'defaultAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$defaultAccountNotifierHash();

  @$internal
  @override
  DefaultAccountNotifier create() => DefaultAccountNotifier();
}

String _$defaultAccountNotifierHash() =>
    r'c7a584ea0e6eb8e5db30255fb74d6d497da501f9';

/// The account preselected for new transactions.

abstract class _$DefaultAccountNotifier extends $AsyncNotifier<Account> {
  FutureOr<Account> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Account>, Account>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Account>, Account>,
              AsyncValue<Account>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Every account with its balance today (PRD ACC-03).

@ProviderFor(AccountBalancesNotifier)
final accountBalancesProvider = AccountBalancesNotifierProvider._();

/// Every account with its balance today (PRD ACC-03).
final class AccountBalancesNotifierProvider
    extends
        $StreamNotifierProvider<AccountBalancesNotifier, List<AccountBalance>> {
  /// Every account with its balance today (PRD ACC-03).
  AccountBalancesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountBalancesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountBalancesNotifierHash();

  @$internal
  @override
  AccountBalancesNotifier create() => AccountBalancesNotifier();
}

String _$accountBalancesNotifierHash() =>
    r'08f4b7c81b662da40ff1e37b20bbcc96916082a7';

/// Every account with its balance today (PRD ACC-03).

abstract class _$AccountBalancesNotifier
    extends $StreamNotifier<List<AccountBalance>> {
  Stream<List<AccountBalance>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AccountBalance>>, List<AccountBalance>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AccountBalance>>,
                List<AccountBalance>
              >,
              AsyncValue<List<AccountBalance>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Month-end balances over the last [months] months (PRD RPT-07).

@ProviderFor(BalanceHistoryNotifier)
final balanceHistoryProvider = BalanceHistoryNotifierFamily._();

/// Month-end balances over the last [months] months (PRD RPT-07).
final class BalanceHistoryNotifierProvider
    extends $StreamNotifierProvider<BalanceHistoryNotifier, BalanceHistory> {
  /// Month-end balances over the last [months] months (PRD RPT-07).
  BalanceHistoryNotifierProvider._({
    required BalanceHistoryNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'balanceHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$balanceHistoryNotifierHash();

  @override
  String toString() {
    return r'balanceHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BalanceHistoryNotifier create() => BalanceHistoryNotifier();

  @override
  bool operator ==(Object other) {
    return other is BalanceHistoryNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$balanceHistoryNotifierHash() =>
    r'de9ad90390a9f2d9d2f52b78a60a19898313833a';

/// Month-end balances over the last [months] months (PRD RPT-07).

final class BalanceHistoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          BalanceHistoryNotifier,
          AsyncValue<BalanceHistory>,
          BalanceHistory,
          Stream<BalanceHistory>,
          int
        > {
  BalanceHistoryNotifierFamily._()
    : super(
        retry: null,
        name: r'balanceHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Month-end balances over the last [months] months (PRD RPT-07).

  BalanceHistoryNotifierProvider call(int months) =>
      BalanceHistoryNotifierProvider._(argument: months, from: this);

  @override
  String toString() => r'balanceHistoryProvider';
}

/// Month-end balances over the last [months] months (PRD RPT-07).

abstract class _$BalanceHistoryNotifier
    extends $StreamNotifier<BalanceHistory> {
  late final _$args = ref.$arg as int;
  int get months => _$args;

  Stream<BalanceHistory> build(int months);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BalanceHistory>, BalanceHistory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BalanceHistory>, BalanceHistory>,
              AsyncValue<BalanceHistory>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// Account writes; each returns its failure (or null) for the UI to show.

@ProviderFor(AccountActions)
final accountActionsProvider = AccountActionsProvider._();

/// Account writes; each returns its failure (or null) for the UI to show.
final class AccountActionsProvider
    extends $NotifierProvider<AccountActions, void> {
  /// Account writes; each returns its failure (or null) for the UI to show.
  AccountActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountActionsHash();

  @$internal
  @override
  AccountActions create() => AccountActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$accountActionsHash() => r'73b1922ab9f8e74693e26816f0db269bab7351dc';

/// Account writes; each returns its failure (or null) for the UI to show.

abstract class _$AccountActions extends $Notifier<void> {
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
