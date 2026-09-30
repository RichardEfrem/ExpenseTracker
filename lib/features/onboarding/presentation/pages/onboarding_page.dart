import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/theme/motion.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/onboarding/presentation/providers/onboarding_notifiers.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// First launch (DESIGN §8.12): currency, default categories, starting
/// cash. Skippable; shown once.
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  var _busy = false;

  OnboardingFormNotifier get _form => ref.read(onboardingFormProvider.notifier);

  OnboardingGate get _gate => ref.read(onboardingGateProvider.notifier);

  void _toast(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _finish() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    final failure = await _gate.complete(
      ref.read(onboardingFormProvider).toInput(),
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (failure != null) {
      _toast(failureMessage(l10n, failure));
      return;
    }
    context.go(AppPaths.home);
  }

  Future<void> _skip() async {
    await _gate.skip();
    if (mounted) context.go(AppPaths.home);
  }

  /// Moving from another phone: skip ahead to restoring a backup.
  Future<void> _restore() async {
    await _gate.skip();
    if (!mounted) return;
    final router = GoRouter.of(context);
    router.go(AppPaths.home);
    await router.push<void>(AppPaths.backup);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final form = ref.watch(onboardingFormProvider);
    const count = OnboardingFormNotifier.pageCount;
    final last = form.page == count - 1;

    return Scaffold(
      body: SafeArea(
        child: AbsorbPointer(
          absorbing: _busy,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.screenPadding,
                  Dimens.space2,
                  Dimens.space2,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        label: l10n.onboarding_step(form.page + 1, count),
                        excludeSemantics: true,
                        child: Row(
                          children: [
                            for (var i = 0; i < count; i++)
                              _Dot(active: i == form.page),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      key: const ValueKey('onboarding-skip'),
                      onPressed: _skip,
                      child: Text(l10n.onboarding_skip),
                    ),
                  ],
                ),
              ),
              if (_busy) const LinearProgressIndicator(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: motionDuration(context, Motion.screen),
                  child: KeyedSubtree(
                    key: ValueKey(form.page),
                    child: switch (form.page) {
                      0 => _CurrencyStep(onRestore: _restore),
                      1 => _CategoriesStep(form: form),
                      _ => _CashStep(form: form),
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.screenPadding),
                child: Row(
                  children: [
                    if (form.page > 0)
                      TextButton(
                        key: const ValueKey('onboarding-back'),
                        onPressed: () => _form.goTo(form.page - 1),
                        child: Text(l10n.onboarding_back),
                      ),
                    const Spacer(),
                    FilledButton(
                      key: const ValueKey('onboarding-next'),
                      onPressed: last
                          ? (form.openingCash == null ? null : _finish)
                          : () => _form.goTo(form.page + 1),
                      child: Text(
                        last ? l10n.onboarding_start : l10n.onboarding_next,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: motionDuration(context, Motion.rowCollapse),
      margin: const EdgeInsetsDirectional.only(end: Dimens.space2),
      width: active ? Dimens.space6 : Dimens.space2,
      height: Dimens.space2,
      decoration: BoxDecoration(
        color: active ? colors.primary : colors.outlineVariant,
        borderRadius: BorderRadius.circular(Dimens.space1),
      ),
    );
  }
}

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: theme.textTheme.headlineSmall),
        ),
        const SizedBox(height: Dimens.space2),
        Text(
          body,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Dimens.space6),
      ],
    );
  }
}

class _CurrencyStep extends StatelessWidget {
  const _CurrencyStep({required this.onRestore});

  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(Dimens.screenPadding),
      children: [
        _StepHeader(
          title: l10n.onboarding_welcome_title,
          body: l10n.onboarding_welcome_body,
        ),
        Card(
          child: ListTile(
            key: const ValueKey('onboarding-currency'),
            selected: true,
            leading: const Icon(Symbols.payments_rounded),
            title: Text(l10n.onboarding_currency_idr),
            subtitle: Text(
              l10n.onboarding_currency_preview(MoneyFormat.full(1250000)),
            ),
            trailing: const Icon(Symbols.check_circle_rounded, fill: 1),
          ),
        ),
        const SizedBox(height: Dimens.space2),
        Text(
          l10n.onboarding_currency_only,
          style: theme.textTheme.bodySmall!.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Dimens.space8),
        Text(l10n.onboarding_moving, style: theme.textTheme.bodyMedium),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            key: const ValueKey('onboarding-restore'),
            icon: const Icon(Symbols.restore_rounded),
            label: Text(l10n.onboarding_restore),
            onPressed: onRestore,
          ),
        ),
      ],
    );
  }
}

class _CategoriesStep extends ConsumerWidget {
  const _CategoriesStep({required this.form});

  final OnboardingForm form;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final notifier = ref.read(onboardingFormProvider.notifier);

    List<Widget> section(CategoryType type, String title) {
      final categories =
          ref.watch(categoriesProvider(type)).value ?? const <Category>[];
      final kept = categories
          .where((c) => !form.removedCategoryIds.contains(c.id))
          .length;
      return [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.space4,
            bottom: Dimens.space1,
          ),
          child: Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
        ),
        for (final category in categories)
          () {
            final keep = !form.removedCategoryIds.contains(category.id);
            return CheckboxListTile(
              key: ValueKey('onboarding-category-${category.id}'),
              contentPadding: EdgeInsets.zero,
              secondary: CategoryIcon(category),
              title: Text(category.name),
              value: keep,
              // At least one category per type, so adding still works.
              onChanged: keep && kept <= 1
                  ? null
                  : (_) => notifier.toggleCategory(category.id),
            );
          }(),
      ];
    }

    return ListView(
      padding: const EdgeInsets.all(Dimens.screenPadding),
      children: [
        _StepHeader(
          title: l10n.onboarding_categories_title,
          body: l10n.onboarding_categories_body,
        ),
        ...section(CategoryType.expense, l10n.type_expense),
        ...section(CategoryType.income, l10n.type_income),
      ],
    );
  }
}

class _CashStep extends ConsumerWidget {
  const _CashStep({required this.form});

  final OnboardingForm form;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.screenPadding),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight - Dimens.screenPadding * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StepHeader(
                title: l10n.onboarding_cash_title,
                body: l10n.onboarding_cash_body,
              ),
              AmountHero(
                type: TransactionType.income,
                expression: form.expression,
                amount: form.openingCash,
              ),
              const SizedBox(height: Dimens.space6),
              AmountKeypad(
                onKey: ref.read(onboardingFormProvider.notifier).onKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
