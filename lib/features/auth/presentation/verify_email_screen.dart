import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Block reporting until the ALU email is verified.
class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.verifyEmailTitle)),
      body: PlaceholderBody(
        title: AppStrings.verifyEmailTitle,
        subtitle: AppStrings.verifyEmailTodo,
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
