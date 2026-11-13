import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Let staff change status and save an optional note.
class StaffIncidentDetailsScreen extends StatelessWidget {
  const StaffIncidentDetailsScreen({required this.incidentId, super.key});

  final String incidentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.staffIncidentDetailsTitle)),
      body: PlaceholderBody(
        title: AppStrings.staffIncidentDetailsTitle,
        subtitle: AppStrings.staffIncidentDetailsTodo,
        children: [
          Text(
            AppStrings.incidentIdLabel(incidentId),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
