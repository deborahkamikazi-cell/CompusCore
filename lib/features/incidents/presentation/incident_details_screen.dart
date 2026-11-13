import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Show the report, photos, and a read-only status timeline.
class IncidentDetailsScreen extends StatelessWidget {
  const IncidentDetailsScreen({required this.incidentId, super.key});

  final String incidentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.incidentDetailsTitle)),
      body: PlaceholderBody(
        title: AppStrings.incidentDetailsTitle,
        subtitle: AppStrings.incidentDetailsTodo,
        children: [
          const SizedBox(height: AppSpacing.xs),
          Text(
            AppStrings.incidentIdLabel(incidentId),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
