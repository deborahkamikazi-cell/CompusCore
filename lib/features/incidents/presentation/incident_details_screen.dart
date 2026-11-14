import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/widgets/error_view.dart';
import 'package:campus_care/core/widgets/loading_indicator.dart';
import 'package:campus_care/features/incidents/presentation/incident_detail_body.dart';
import 'package:campus_care/features/incidents/presentation/incident_providers.dart';

class IncidentDetailsScreen extends ConsumerWidget {
  const IncidentDetailsScreen({required this.incidentId, super.key});

  final String incidentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incident = ref.watch(incidentByIdProvider(incidentId));
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.incidentDetails)),
      body: incident.when(
        loading: () => const LoadingIndicator(),
        error: (_, _) => ErrorView(
          message: AppStrings.couldNotLoadIncident,
          onRetry: () => ref.invalidate(incidentByIdProvider(incidentId)),
        ),
        data: (value) {
          if (value == null) {
            return const ErrorView(message: AppStrings.incidentNotFound);
          }
          return IncidentDetailBody(incident: value);
        },
      ),
    );
  }
}
