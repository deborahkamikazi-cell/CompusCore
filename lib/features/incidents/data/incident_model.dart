import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

/// Firestore mapping for [Incident]. Document id is stored separately.
class IncidentModel {
  const IncidentModel(this.incident);

  final Incident incident;

  factory IncidentModel.fromEntity(Incident incident) {
    return IncidentModel(incident);
  }

  Incident toEntity() => incident;

  factory IncidentModel.fromMap(String id, Map<String, dynamic> map) {
    return IncidentModel(
      Incident(
        id: id,
        referenceNumber: map['referenceNumber'] as String? ?? '',
        title: map['title'] as String? ?? '',
        description: map['description'] as String? ?? '',
        category: IncidentCategory.fromWire(map['category'] as String?),
        location: IncidentLocation.fromMap(_asStringMap(map['location'])),
        priority: IncidentPriority.fromWire(map['priority'] as String?),
        status: IncidentStatus.fromWire(map['status'] as String?),
        imageUrls: _asStringList(map['imageUrls']),
        reportedBy: map['reportedBy'] as String? ?? '',
        reporterName: map['reporterName'] as String? ?? '',
        createdAt: _readDate(map['createdAt']),
        updatedAt: _readDate(map['updatedAt']),
        staffNote: map['staffNote'] as String?,
        statusTimestamps: _readTimestamps(map['statusTimestamps']),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'referenceNumber': incident.referenceNumber,
      'title': incident.title,
      'description': incident.description,
      'category': incident.category.wireValue,
      'location': incident.location.toMap(),
      'priority': incident.priority.wireValue,
      'status': incident.status.wireValue,
      'imageUrls': incident.imageUrls,
      'reportedBy': incident.reportedBy,
      'reporterName': incident.reporterName,
      'createdAt': Timestamp.fromDate(incident.createdAt),
      'updatedAt': Timestamp.fromDate(incident.updatedAt),
      'staffNote': incident.staffNote,
      'statusTimestamps': {
        for (final entry in incident.statusTimestamps.entries)
          entry.key.wireValue: entry.value.toIso8601String(),
      },
    };
  }
}

Map<String, dynamic>? _asStringMap(Object? value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return null;
}

List<String> _asStringList(Object? value) {
  if (value is Iterable) {
    return value.map((item) => item.toString()).toList();
  }
  return const [];
}

/// Accepts Firestore [Timestamp], [DateTime], epoch millis, or ISO strings.
DateTime _readDate(Object? value) {
  if (value is Timestamp) {
    return value.toDate();
  }
  if (value is DateTime) {
    return value;
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  if (value is String) {
    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }
  return DateTime.fromMillisecondsSinceEpoch(0);
}

Map<IncidentStatus, DateTime> _readTimestamps(Object? value) {
  if (value is! Map) {
    return const <IncidentStatus, DateTime>{};
  }
  final timestamps = <IncidentStatus, DateTime>{};
  for (final entry in value.entries) {
    timestamps[IncidentStatus.fromWire(entry.key.toString())] = _readDate(
      entry.value,
    );
  }
  return timestamps;
}
