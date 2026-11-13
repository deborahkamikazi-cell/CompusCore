import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';
import 'package:campus_care/features/incidents/data/mock_incident_repository.dart';

/// TODO: All-campus incident queue with search and status filters.
class ManageIncidentsScreen extends StatelessWidget {
  const ManageIncidentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.manageIncidentsTitle)),
      body: PlaceholderBody(
        title: AppStrings.manageIncidentsTitle,
        subtitle: AppStrings.manageIncidentsTodo,
        children: [
          TextButton(
            onPressed: () => context.push(
              RouteNames.staffIncidentDetails(SampleIncidentIds.leakingPipe),
            ),
            child: const Text(AppStrings.viewSampleReport),
          ),
        ],
      ),
    );
  }
}
