import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';

/// TODO: Resolve the persisted session, then leave this screen automatically.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.splashTitle)),
      body: PlaceholderBody(
        title: AppStrings.splashTitle,
        subtitle: AppStrings.splashTodo,
        children: [
          PrimaryButton(
            label: AppStrings.continueLabel,
            onPressed: () {
              ref.read(authControllerProvider.notifier).finishSplash();
              context.go(RouteNames.onboarding);
            },
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}
