import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/features/auth/presentation/auth_controller.dart';
import 'package:campus_care/features/incidents/data/mock_incident_repository.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';

const incidentFetchDelay = Duration(milliseconds: 450);

final studentIncidentsProvider = StreamProvider<List<Incident>>((ref) async* {
  final user = ref.watch(authControllerProvider).user;
  if (user == null) {
    yield const [];
    return;
  }
  await Future<void>.delayed(incidentFetchDelay);
  yield* ref.watch(incidentRepositoryProvider).watchByReporter(user.uid);
});

final allIncidentsProvider = StreamProvider<List<Incident>>((ref) async* {
  await Future<void>.delayed(incidentFetchDelay);
  yield* ref.watch(incidentRepositoryProvider).watchAll();
});

final incidentByIdProvider = StreamProvider.family<Incident?, String>((
  ref,
  id,
) async* {
  await Future<void>.delayed(incidentFetchDelay);
  yield* ref.watch(incidentRepositoryProvider).watchAll().map((items) {
    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  });
});

class LastSubmittedIncident extends Notifier<Incident?> {
  @override
  Incident? build() => null;

  void remember(Incident incident) => state = incident;
}

final lastSubmittedIncidentProvider =
    NotifierProvider<LastSubmittedIncident, Incident?>(
      LastSubmittedIncident.new,
    );

class SelectedReportCategory extends Notifier<IncidentCategory?> {
  @override
  IncidentCategory? build() => null;

  void select(IncidentCategory? category) => state = category;
}

final selectedReportCategoryProvider =
    NotifierProvider<SelectedReportCategory, IncidentCategory?>(
      SelectedReportCategory.new,
    );
