import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/router/module_routes.dart';
import 'package:expense_tracker/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:expense_tracker/features/onboarding/presentation/providers/onboarding_notifiers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// While onboarding is pending every navigation goes to it; once done, it
/// can't be reached again.
String? onboardingRedirect({required bool pending, required Uri uri}) {
  final atWelcome = uri.path == AppPaths.welcome;
  if (pending && !atWelcome) return AppPaths.welcome;
  if (!pending && atWelcome) return AppPaths.home;
  return null;
}

ModuleRoutes onboardingRoutes() => ModuleRoutes(
  redirect: (context, state) => onboardingRedirect(
    pending: ProviderScope.containerOf(
      context,
      listen: false,
    ).read(onboardingGateProvider),
    uri: state.uri,
  ),
  routes: [
    GoRoute(
      path: AppPaths.welcome,
      builder: (context, state) => const OnboardingPage(),
    ),
  ],
);
