// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transactionLocalDataSource)
final transactionLocalDataSourceProvider =
    TransactionLocalDataSourceProvider._();

final class TransactionLocalDataSourceProvider
    extends
        $FunctionalProvider<
          TransactionLocalDataSource,
          TransactionLocalDataSource,
          TransactionLocalDataSource
        >
    with $Provider<TransactionLocalDataSource> {
  TransactionLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<TransactionLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionLocalDataSource create(Ref ref) {
    return transactionLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionLocalDataSource>(value),
    );
  }
}

String _$transactionLocalDataSourceHash() =>
    r'655de7ca0123095b56f98c23ff5422eb5100cacd';

@ProviderFor(transactionRepository)
final transactionRepositoryProvider = TransactionRepositoryProvider._();

final class TransactionRepositoryProvider
    extends
        $FunctionalProvider<
          TransactionRepository,
          TransactionRepository,
          TransactionRepository
        >
    with $Provider<TransactionRepository> {
  TransactionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransactionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRepository create(Ref ref) {
    return transactionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRepository>(value),
    );
  }
}

String _$transactionRepositoryHash() =>
    r'656cb62334de514bfd87c3a009f7fab708dbee1a';

@ProviderFor(addTransaction)
final addTransactionProvider = AddTransactionProvider._();

final class AddTransactionProvider
    extends $FunctionalProvider<AddTransaction, AddTransaction, AddTransaction>
    with $Provider<AddTransaction> {
  AddTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTransactionHash();

  @$internal
  @override
  $ProviderElement<AddTransaction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTransaction create(Ref ref) {
    return addTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTransaction>(value),
    );
  }
}

String _$addTransactionHash() => r'83fa3bab29458bc565b0f1a1a0572fcfb57e87a3';

@ProviderFor(updateTransaction)
final updateTransactionProvider = UpdateTransactionProvider._();

final class UpdateTransactionProvider
    extends
        $FunctionalProvider<
          UpdateTransaction,
          UpdateTransaction,
          UpdateTransaction
        >
    with $Provider<UpdateTransaction> {
  UpdateTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTransactionHash();

  @$internal
  @override
  $ProviderElement<UpdateTransaction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateTransaction create(Ref ref) {
    return updateTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTransaction>(value),
    );
  }
}

String _$updateTransactionHash() => r'e61db019be6daec74181b97f84a430e55a0b9837';

@ProviderFor(deleteTransaction)
final deleteTransactionProvider = DeleteTransactionProvider._();

final class DeleteTransactionProvider
    extends
        $FunctionalProvider<
          DeleteTransaction,
          DeleteTransaction,
          DeleteTransaction
        >
    with $Provider<DeleteTransaction> {
  DeleteTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTransactionHash();

  @$internal
  @override
  $ProviderElement<DeleteTransaction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTransaction create(Ref ref) {
    return deleteTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTransaction>(value),
    );
  }
}

String _$deleteTransactionHash() => r'271fb3c526506d8907d5d858c5e9e17c0b58ed44';

@ProviderFor(restoreTransaction)
final restoreTransactionProvider = RestoreTransactionProvider._();

final class RestoreTransactionProvider
    extends
        $FunctionalProvider<
          RestoreTransaction,
          RestoreTransaction,
          RestoreTransaction
        >
    with $Provider<RestoreTransaction> {
  RestoreTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restoreTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restoreTransactionHash();

  @$internal
  @override
  $ProviderElement<RestoreTransaction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestoreTransaction create(Ref ref) {
    return restoreTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestoreTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestoreTransaction>(value),
    );
  }
}

String _$restoreTransactionHash() =>
    r'60daecc5e645a92dcaf87fbd39ffe299b98d11a2';

@ProviderFor(duplicateTransaction)
final duplicateTransactionProvider = DuplicateTransactionProvider._();

final class DuplicateTransactionProvider
    extends
        $FunctionalProvider<
          DuplicateTransaction,
          DuplicateTransaction,
          DuplicateTransaction
        >
    with $Provider<DuplicateTransaction> {
  DuplicateTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'duplicateTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$duplicateTransactionHash();

  @$internal
  @override
  $ProviderElement<DuplicateTransaction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DuplicateTransaction create(Ref ref) {
    return duplicateTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DuplicateTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DuplicateTransaction>(value),
    );
  }
}

String _$duplicateTransactionHash() =>
    r'c07bb3f44b4011f9538633fa61ee71895e4a8854';

@ProviderFor(getTransaction)
final getTransactionProvider = GetTransactionProvider._();

final class GetTransactionProvider
    extends $FunctionalProvider<GetTransaction, GetTransaction, GetTransaction>
    with $Provider<GetTransaction> {
  GetTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionHash();

  @$internal
  @override
  $ProviderElement<GetTransaction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTransaction create(Ref ref) {
    return getTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTransaction>(value),
    );
  }
}

String _$getTransactionHash() => r'4e836b844a133668678afd519549f133cfea2bc3';

@ProviderFor(watchTransaction)
final watchTransactionProvider = WatchTransactionProvider._();

final class WatchTransactionProvider
    extends
        $FunctionalProvider<
          WatchTransaction,
          WatchTransaction,
          WatchTransaction
        >
    with $Provider<WatchTransaction> {
  WatchTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTransactionHash();

  @$internal
  @override
  $ProviderElement<WatchTransaction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchTransaction create(Ref ref) {
    return watchTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTransaction>(value),
    );
  }
}

String _$watchTransactionHash() => r'645e1cc3923203c3470bae5a51203980ee3140b2';

@ProviderFor(watchRecentTransactions)
final watchRecentTransactionsProvider = WatchRecentTransactionsProvider._();

final class WatchRecentTransactionsProvider
    extends
        $FunctionalProvider<
          WatchRecentTransactions,
          WatchRecentTransactions,
          WatchRecentTransactions
        >
    with $Provider<WatchRecentTransactions> {
  WatchRecentTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchRecentTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchRecentTransactionsHash();

  @$internal
  @override
  $ProviderElement<WatchRecentTransactions> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchRecentTransactions create(Ref ref) {
    return watchRecentTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchRecentTransactions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchRecentTransactions>(value),
    );
  }
}

String _$watchRecentTransactionsHash() =>
    r'599b2261e1e4fee8615e7487624fd6c414095e11';

@ProviderFor(getLastUsed)
final getLastUsedProvider = GetLastUsedProvider._();

final class GetLastUsedProvider
    extends $FunctionalProvider<GetLastUsed, GetLastUsed, GetLastUsed>
    with $Provider<GetLastUsed> {
  GetLastUsedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLastUsedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLastUsedHash();

  @$internal
  @override
  $ProviderElement<GetLastUsed> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetLastUsed create(Ref ref) {
    return getLastUsed(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLastUsed value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLastUsed>(value),
    );
  }
}

String _$getLastUsedHash() => r'c4f05e818b87b7907d966a903e44c43bfa943096';

@ProviderFor(setLastUsed)
final setLastUsedProvider = SetLastUsedProvider._();

final class SetLastUsedProvider
    extends $FunctionalProvider<SetLastUsed, SetLastUsed, SetLastUsed>
    with $Provider<SetLastUsed> {
  SetLastUsedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setLastUsedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setLastUsedHash();

  @$internal
  @override
  $ProviderElement<SetLastUsed> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SetLastUsed create(Ref ref) {
    return setLastUsed(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetLastUsed value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetLastUsed>(value),
    );
  }
}

String _$setLastUsedHash() => r'e12753e7bd41f4cfcd9fddf45435f165c2c1c696';

@ProviderFor(evaluateAmountExpression)
final evaluateAmountExpressionProvider = EvaluateAmountExpressionProvider._();

final class EvaluateAmountExpressionProvider
    extends
        $FunctionalProvider<
          EvaluateAmountExpression,
          EvaluateAmountExpression,
          EvaluateAmountExpression
        >
    with $Provider<EvaluateAmountExpression> {
  EvaluateAmountExpressionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'evaluateAmountExpressionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$evaluateAmountExpressionHash();

  @$internal
  @override
  $ProviderElement<EvaluateAmountExpression> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EvaluateAmountExpression create(Ref ref) {
    return evaluateAmountExpression(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EvaluateAmountExpression value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EvaluateAmountExpression>(value),
    );
  }
}

String _$evaluateAmountExpressionHash() =>
    r'f42f58dcc0fcd6e67f80281a57e50c7fa7229896';
