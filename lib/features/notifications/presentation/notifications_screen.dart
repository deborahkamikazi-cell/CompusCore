import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: List status-change notifications for the signed-in student or staff user.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.notificationsTitle)),
      body: const PlaceholderBody(
        title: AppStrings.notificationsTitle,
        subtitle: AppStrings.notificationsTodo,
      ),
    );
  }
}
