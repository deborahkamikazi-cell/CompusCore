import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';

/// TODO: Replace mock role buttons with an ALU email and password form.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.loginTitle)),
      body: PlaceholderBody(
        title: AppStrings.loginTitle,
        subtitle: AppStrings.loginTodo,
        children: [
          PrimaryButton(
            label: AppStrings.continueAsStudent,
            onPressed: controller.signInAsStudent,
          ),
          const SizedBox(height: AppSpacing.sm),
          PrimaryButton(
            label: AppStrings.continueAsStaff,
            onPressed: controller.signInAsStaff,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => context.go(RouteNames.register),
            child: const Text(AppStrings.createAccount),
          ),
          TextButton(
            onPressed: () => context.go(RouteNames.forgotPassword),
            child: const Text(AppStrings.forgotPassword),
          ),
          TextButton(
            onPressed: () => context.go(RouteNames.verifyEmail),
            child: const Text(AppStrings.verifyEmail),
          ),
        ],
      ),
    );
  }
}
