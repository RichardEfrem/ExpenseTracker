import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/features/onboarding/onboarding_routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String? redirect(String location, {required bool pending}) =>
      onboardingRedirect(pending: pending, uri: Uri.parse(location));

  test('pending: every location goes to onboarding', () {
    for (final location in [
      AppPaths.home,
      AppPaths.activity,
      AppPaths.addOfType('expense'),
      AppPaths.backup,
    ]) {
      expect(redirect(location, pending: true), AppPaths.welcome);
    }
    expect(redirect(AppPaths.welcome, pending: true), isNull);
  });

  test('done: onboarding is unreachable, the rest is untouched', () {
    expect(redirect(AppPaths.welcome, pending: false), AppPaths.home);
    expect(redirect(AppPaths.activity, pending: false), isNull);
  });
}
