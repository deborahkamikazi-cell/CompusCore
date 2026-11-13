import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

/// Incident persistence. Firebase implementation comes in a later phase.
abstract class IncidentRepository {
  Stream<List<Incident>> watchAll();

  Stream<List<Incident>> watchByReporter(String uid);

  Future<Incident?> getById(String id);

  Future<Incident> create(Incident draft);

  Future<void> updateStatus({
    required String id,
    required IncidentStatus status,
    String? staffNote,
  });
}
