// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_rule_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
/// schedule. New rules default to monthly from today, created automatically.

@ProviderFor(RecurringRuleFormNotifier)
final recurringRuleFormProvider = RecurringRuleFormNotifierFamily._();

/// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
/// schedule. New rules default to monthly from today, created automatically.
final class RecurringRuleFormNotifierProvider
    extends
        $AsyncNotifierProvider<
          RecurringRuleFormNotifier,
          RecurringRuleFormState
        > {
  /// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
  /// schedule. New rules default to monthly from today, created automatically.
  RecurringRuleFormNotifierProvider._({
    required RecurringRuleFormNotifierFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'recurringRuleFormProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$recurringRuleFormNotifierHash();

  @override
  String toString() {
    return r'recurringRuleFormProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RecurringRuleFormNotifier create() => RecurringRuleFormNotifier();

  @override
  bool operator ==(Object other) {
    return other is RecurringRuleFormNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$recurringRuleFormNotifierHash() =>
    r'89403afda69aed0105928cb62b6a3b1491f31aa4';

/// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
/// schedule. New rules default to monthly from today, created automatically.

final class RecurringRuleFormNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RecurringRuleFormNotifier,
          AsyncValue<RecurringRuleFormState>,
          RecurringRuleFormState,
          FutureOr<RecurringRuleFormState>,
          String?
        > {
  RecurringRuleFormNotifierFamily._()
    : super(
        retry: null,
        name: r'recurringRuleFormProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
  /// schedule. New rules default to monthly from today, created automatically.

  RecurringRuleFormNotifierProvider call({String? editId}) =>
      RecurringRuleFormNotifierProvider._(argument: editId, from: this);

  @override
  String toString() => r'recurringRuleFormProvider';
}

/// The new/edit rule screen (DESIGN §8.9): the Add screen's fields plus the
/// schedule. New rules default to monthly from today, created automatically.

abstract class _$RecurringRuleFormNotifier
    extends $AsyncNotifier<RecurringRuleFormState> {
  late final _$args = ref.$arg as String?;
  String? get editId => _$args;

  FutureOr<RecurringRuleFormState> build({String? editId});
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<RecurringRuleFormState>, RecurringRuleFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<RecurringRuleFormState>,
                RecurringRuleFormState
              >,
              AsyncValue<RecurringRuleFormState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(editId: _$args));
  }
}
