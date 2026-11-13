import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Three short pages explaining how students report and track issues.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.onboardingTitle)),
      body: PlaceholderBody(
        title: AppStrings.onboardingTitle,
        subtitle: AppStrings.onboardingTodo,
        children: [
          TextButton(
            onPressed: () => context.go(RouteNames.login),
            child: const Text(AppStrings.signIn),
          ),
          TextButton(
            onPressed: () => context.go(RouteNames.register),
            child: const Text(AppStrings.createAccount),
          ),
        ],
      ),
    );
  }
}
