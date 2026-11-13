import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';
import 'package:campus_care/features/incidents/data/mock_incident_repository.dart';

/// TODO: Searchable, filterable list of the signed-in student's reports.
class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportsTitle)),
      body: PlaceholderBody(
        title: AppStrings.reportsTitle,
        subtitle: AppStrings.reportsTodo,
        children: [
          TextButton(
            onPressed: () => context.push(
              RouteNames.studentReportDetails(SampleIncidentIds.leakingPipe),
            ),
            child: const Text(AppStrings.viewSampleReport),
          ),
          TextButton(
            onPressed: () => context.push(RouteNames.studentReportNew),
            child: const Text(AppStrings.newReport),
          ),
        ],
      ),
    );
  }
}
