import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';

/// TODO: Show account details and sign out. Shared by student and staff shells.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;
    final subtitle = user == null
        ? AppStrings.profileTodo
        : '${AppStrings.signedInAs(user.fullName, user.role.label)}\n${AppStrings.profileTodo}';

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profileTitle)),
      body: PlaceholderBody(
        title: AppStrings.profileTitle,
        subtitle: subtitle,
        children: [
          TextButton(
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            child: const Text(AppStrings.signOut),
          ),
        ],
      ),
    );
  }
}
