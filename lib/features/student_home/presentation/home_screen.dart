import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Student home with summary cards and a shortcut to report an incident.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.homeTitle)),
      body: PlaceholderBody(
        title: AppStrings.homeTitle,
        subtitle: AppStrings.homeTodo,
        children: [
          TextButton(
            onPressed: () => context.push(RouteNames.studentReportNew),
            child: const Text(AppStrings.newReport),
          ),
          TextButton(
            onPressed: () => context.go(RouteNames.studentReports),
            child: const Text(AppStrings.reports),
          ),
        ],
      ),
    );
  }
}
