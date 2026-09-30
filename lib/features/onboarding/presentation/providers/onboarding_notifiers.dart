import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/onboarding/data/onboarding_providers.dart';
import 'package:expense_tracker/features/onboarding/domain/entities/onboarding_input.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_notifiers.freezed.dart';
part 'onboarding_notifiers.g.dart';

/// Whether the router sends everything to onboarding. False until [check]
/// runs, which `main.dart` does before the first frame; so tests and data
/// erased mid-session never jump into onboarding. Deliberately app-lifetime.
@Riverpod(keepAlive: true)
class OnboardingGate extends _$OnboardingGate {
  @override
  bool build() => false;

  /// Loads the flag; a failure to read it never blocks the app.
  Future<void> check() async {
    final pending = await ref.read(getOnboardingPendingProvider)();
    state = pending.getOrElse((_) => false);
  }

  Future<Failure?> complete(OnboardingInput input) async {
    final failure = (await ref.read(completeOnboardingProvider)(
      input,
    )).failureOrNull;
    if (failure == null) state = false;
    return failure;
  }

  Future<Failure?> skip() async {
    final failure = (await ref.read(skipOnboardingProvider)()).failureOrNull;
    // Even if saving fails, let the user in; it shows again next launch.
    state = false;
    return failure;
  }
}

@freezed
abstract class OnboardingForm with _$OnboardingForm {
  const factory OnboardingForm({
    @Default(0) int page,
    @Default(<String>{}) Set<String> removedCategoryIds,

    /// Keypad text for the starting cash, e.g. `250000+50000`.
    @Default('') String expression,

    /// Its value; null while the expression is invalid.
    @Default(0) int? openingCash,
  }) = _OnboardingForm;

  const OnboardingForm._();

  OnboardingInput toInput() => OnboardingInput(
    removedCategoryIds: removedCategoryIds,
    openingCash: openingCash ?? 0,
  );
}

/// The three onboarding pages' choices (DESIGN §8.12).
@riverpod
class OnboardingFormNotifier extends _$OnboardingFormNotifier {
  static const pageCount = 3;

  @override
  OnboardingForm build() => const OnboardingForm();

  void goTo(int page) =>
      state = state.copyWith(page: page.clamp(0, pageCount - 1));

  void toggleCategory(String id) {
    final removed = {...state.removedCategoryIds};
    if (!removed.remove(id)) removed.add(id);
    state = state.copyWith(removedCategoryIds: removed);
  }

  void onKey(KeypadKey key) {
    final expression = applyKeypadKey(state.expression, key);
    final value = expression.isEmpty
        ? 0
        : ref.read(evaluateAmountExpressionProvider)(expression).toNullable();
    state = state.copyWith(expression: expression, openingCash: value);
  }
}
