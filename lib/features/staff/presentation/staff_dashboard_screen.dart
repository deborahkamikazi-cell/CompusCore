import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Staff overview of open, in-progress, and critical incidents.
class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.staffDashboardTitle)),
      body: PlaceholderBody(
        title: AppStrings.staffDashboardTitle,
        subtitle: AppStrings.staffDashboardTodo,
        children: [
          TextButton(
            onPressed: () => context.go(RouteNames.staffIncidents),
            child: const Text(AppStrings.incidents),
          ),
        ],
      ),
    );
  }
}
