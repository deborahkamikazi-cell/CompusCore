import 'package:campus_care/features/incidents/data/incident_model.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('IncidentModel round-trips Firestore fields', () {
    final createdAt = DateTime.utc(2026, 3, 2, 9, 15);
    final incident = Incident(
      id: 'inc-0142',
      referenceNumber: 'CC-2026-0142',
      title: 'Leaking pipe',
      description: 'Water in the hallway',
      category: IncidentCategory.water,
      location: const IncidentLocation(
        building: 'Block B',
        floor: '2',
        room: 'Washrooms',
      ),
      priority: IncidentPriority.high,
      status: IncidentStatus.underReview,
      imageUrls: const ['https://example.com/pipe.jpg'],
      reportedBy: 'student-001',
      reporterName: 'Amina Uwase',
      createdAt: createdAt,
      updatedAt: createdAt,
      staffNote: 'Assigned to facilities',
    );

    final map = IncidentModel.fromEntity(incident).toMap();
    expect(map['category'], 'water');
    expect(map['status'], 'under_review');
    expect(map['priority'], 'high');
    expect(map['createdAt'], isA<Timestamp>());

    final restored = IncidentModel.fromMap('inc-0142', {
      ...map,
      'createdAt': createdAt,
      'updatedAt': createdAt.toIso8601String(),
    }).toEntity();

    expect(restored, incident.copyWith(updatedAt: createdAt));
    expect(restored.location.displayLabel, 'Block B, 2, Washrooms');
  });
}
