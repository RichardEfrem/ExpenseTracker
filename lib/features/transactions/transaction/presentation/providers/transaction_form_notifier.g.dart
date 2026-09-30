// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
/// date, note; remembers the last-used category per type.

@ProviderFor(TransactionFormNotifier)
final transactionFormProvider = TransactionFormNotifierFamily._();

/// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
/// date, note; remembers the last-used category per type.
final class TransactionFormNotifierProvider
    extends
        $AsyncNotifierProvider<TransactionFormNotifier, TransactionFormState> {
  /// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
  /// date, note; remembers the last-used category per type.
  TransactionFormNotifierProvider._({
    required TransactionFormNotifierFamily super.from,
    required (TransactionType, {String? editId}) super.argument,
  }) : super(
         retry: null,
         name: r'transactionFormProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionFormNotifierHash();

  @override
  String toString() {
    return r'transactionFormProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  TransactionFormNotifier create() => TransactionFormNotifier();

  @override
  bool operator ==(Object other) {
    return other is TransactionFormNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionFormNotifierHash() =>
    r'247404e191863eb4abc4d0f244cffe5a054385d1';

/// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
/// date, note; remembers the last-used category per type.

final class TransactionFormNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TransactionFormNotifier,
          AsyncValue<TransactionFormState>,
          TransactionFormState,
          FutureOr<TransactionFormState>,
          (TransactionType, {String? editId})
        > {
  TransactionFormNotifierFamily._()
    : super(
        retry: null,
        name: r'transactionFormProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
  /// date, note; remembers the last-used category per type.

  TransactionFormNotifierProvider call(
    TransactionType initialType, {
    String? editId,
  }) => TransactionFormNotifierProvider._(
    argument: (initialType, editId: editId),
    from: this,
  );

  @override
  String toString() => r'transactionFormProvider';
}

/// The Add/Edit screen (PRD TX-01…06): keypad expression, type, category,
/// date, note; remembers the last-used category per type.

abstract class _$TransactionFormNotifier
    extends $AsyncNotifier<TransactionFormState> {
  late final _$args = ref.$arg as (TransactionType, {String? editId});
  TransactionType get initialType => _$args.$1;
  String? get editId => _$args.editId;

  FutureOr<TransactionFormState> build(
    TransactionType initialType, {
    String? editId,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<TransactionFormState>, TransactionFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<TransactionFormState>,
                TransactionFormState
              >,
              AsyncValue<TransactionFormState>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(_$args.$1, editId: _$args.editId),
    );
  }
}
