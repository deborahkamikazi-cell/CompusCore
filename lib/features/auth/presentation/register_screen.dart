import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Collect name, ALU email, and password, then send verification.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.registerTitle)),
      body: PlaceholderBody(
        title: AppStrings.registerTitle,
        subtitle: AppStrings.registerTodo,
        children: [
          TextButton(
            onPressed: () => context.go(RouteNames.verifyEmail),
            child: const Text(AppStrings.verifyEmail),
          ),
          TextButton(
            onPressed: () => context.go(RouteNames.login),
            child: const Text(AppStrings.backToLogin),
          ),
        ],
      ),
    );
  }
}
