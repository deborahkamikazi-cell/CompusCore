import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/app.dart';
import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/features/auth/presentation/login_screen.dart';

void main() {
  testWidgets('mock sign-in reaches the role shell and blocks the other role', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: CampusCareApp()));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.splashTitle), findsWidgets);

    await tester.tap(find.text(AppStrings.continueLabel));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.onboardingTitle), findsWidgets);

    await tester.tap(find.text(AppStrings.signIn));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.loginTitle), findsWidgets);

    await tester.enterText(
      find.byKey(LoginScreen.emailFieldKey),
      'd.uwase@alustudent.com',
    );
    await tester.enterText(
      find.byKey(LoginScreen.passwordFieldKey),
      'password',
    );
    await tester.tap(find.text(AppStrings.logIn));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.homeTitle), findsWidgets);

    final context = tester.element(find.text(AppStrings.homeTitle).first);
    GoRouter.of(context).go(RouteNames.staffDashboard);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.homeTitle), findsWidgets);
    expect(find.text(AppStrings.staffDashboardTitle), findsNothing);
  });
}
