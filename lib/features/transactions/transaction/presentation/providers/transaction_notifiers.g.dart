// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// One transaction with its category and accounts; null once deleted.

@ProviderFor(TransactionNotifier)
final transactionProvider = TransactionNotifierFamily._();

/// One transaction with its category and accounts; null once deleted.
final class TransactionNotifierProvider
    extends $StreamNotifierProvider<TransactionNotifier, TransactionView?> {
  /// One transaction with its category and accounts; null once deleted.
  TransactionNotifierProvider._({
    required TransactionNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'transactionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionNotifierHash();

  @override
  String toString() {
    return r'transactionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TransactionNotifier create() => TransactionNotifier();

  @override
  bool operator ==(Object other) {
    return other is TransactionNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionNotifierHash() =>
    r'c278f70e401c813c404f79ec6db85a1c467704a3';

/// One transaction with its category and accounts; null once deleted.

final class TransactionNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TransactionNotifier,
          AsyncValue<TransactionView?>,
          TransactionView?,
          Stream<TransactionView?>,
          String
        > {
  TransactionNotifierFamily._()
    : super(
        retry: null,
        name: r'transactionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One transaction with its category and accounts; null once deleted.

  TransactionNotifierProvider call(String id) =>
      TransactionNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'transactionProvider';
}

/// One transaction with its category and accounts; null once deleted.

abstract class _$TransactionNotifier extends $StreamNotifier<TransactionView?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  Stream<TransactionView?> build(String id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TransactionView?>, TransactionView?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TransactionView?>, TransactionView?>,
              AsyncValue<TransactionView?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// The newest [limit] transactions.

@ProviderFor(RecentTransactionsNotifier)
final recentTransactionsProvider = RecentTransactionsNotifierFamily._();

/// The newest [limit] transactions.
final class RecentTransactionsNotifierProvider
    extends
        $StreamNotifierProvider<
          RecentTransactionsNotifier,
          List<TransactionView>
        > {
  /// The newest [limit] transactions.
  RecentTransactionsNotifierProvider._({
    required RecentTransactionsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'recentTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recentTransactionsNotifierHash();

  @override
  String toString() {
    return r'recentTransactionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RecentTransactionsNotifier create() => RecentTransactionsNotifier();

  @override
  bool operator ==(Object other) {
    return other is RecentTransactionsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recentTransactionsNotifierHash() =>
    r'2af798110edc3598a000f38e774af115322e822f';

/// The newest [limit] transactions.

final class RecentTransactionsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RecentTransactionsNotifier,
          AsyncValue<List<TransactionView>>,
          List<TransactionView>,
          Stream<List<TransactionView>>,
          int
        > {
  RecentTransactionsNotifierFamily._()
    : super(
        retry: null,
        name: r'recentTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The newest [limit] transactions.

  RecentTransactionsNotifierProvider call(int limit) =>
      RecentTransactionsNotifierProvider._(argument: limit, from: this);

  @override
  String toString() => r'recentTransactionsProvider';
}

/// The newest [limit] transactions.

abstract class _$RecentTransactionsNotifier
    extends $StreamNotifier<List<TransactionView>> {
  late final _$args = ref.$arg as int;
  int get limit => _$args;

  Stream<List<TransactionView>> build(int limit);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TransactionView>>, List<TransactionView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransactionView>>,
                List<TransactionView>
              >,
              AsyncValue<List<TransactionView>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// Row-level writes. Watched lists update themselves.

@ProviderFor(TransactionActions)
final transactionActionsProvider = TransactionActionsProvider._();

/// Row-level writes. Watched lists update themselves.
final class TransactionActionsProvider
    extends $NotifierProvider<TransactionActions, void> {
  /// Row-level writes. Watched lists update themselves.
  TransactionActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionActionsHash();

  @$internal
  @override
  TransactionActions create() => TransactionActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$transactionActionsHash() =>
    r'b0723f75d7dfeed5262be1319f40e00b8bf2dc99';

/// Row-level writes. Watched lists update themselves.

abstract class _$TransactionActions extends $Notifier<void> {
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
