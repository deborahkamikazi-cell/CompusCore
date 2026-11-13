import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Email a password reset link to a verified ALU address.
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.forgotPasswordTitle)),
      body: PlaceholderBody(
        title: AppStrings.forgotPasswordTitle,
        subtitle: AppStrings.forgotPasswordTodo,
        children: [
          TextButton(
            onPressed: () => context.go(RouteNames.login),
            child: const Text(AppStrings.backToLogin),
          ),
        ],
      ),
    );
  }
}
