import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Form for title, category, description, location, photos, and priority.
class ReportIncidentScreen extends StatelessWidget {
  const ReportIncidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportIncidentTitle)),
      body: PlaceholderBody(
        title: AppStrings.reportIncidentTitle,
        subtitle: AppStrings.reportIncidentTodo,
        children: [
          TextButton(
            onPressed: () => context.push(RouteNames.studentReportSuccess),
            child: const Text(AppStrings.continueLabel),
          ),
        ],
      ),
    );
  }
}
