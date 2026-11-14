import 'package:equatable/equatable.dart';

import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

class IncidentLocation extends Equatable {
  const IncidentLocation({required this.building, this.floor, this.room});

  final String building;
  final String? floor;
  final String? room;

  String get displayLabel {
    final parts = <String>[
      building,
      if (floor != null && floor!.isNotEmpty) floor!,
      if (room != null && room!.isNotEmpty) room!,
    ];
    return parts.where((part) => part.isNotEmpty).join(', ');
  }

  /// Room and floor, used under a title that already names the building.
  String get placeLabel {
    final parts = <String>[
      if (floor != null && floor!.isNotEmpty) floor!,
      if (room != null && room!.isNotEmpty) room!,
    ];
    if (parts.isEmpty) {
      return building;
    }
    return parts.join(', ');
  }

  factory IncidentLocation.fromMap(Map<String, dynamic>? map) {
    final data = map ?? const <String, dynamic>{};
    return IncidentLocation(
      building: data['building'] as String? ?? '',
      floor: data['floor'] as String?,
      room: data['room'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'building': building, 'floor': floor, 'room': room};
  }

  @override
  List<Object?> get props => [building, floor, room];
}

class Incident extends Equatable {
  const Incident({
    required this.id,
    required this.referenceNumber,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.priority,
    required this.status,
    required this.imageUrls,
    required this.reportedBy,
    required this.reporterName,
    required this.createdAt,
    required this.updatedAt,
    this.staffNote,
    this.statusTimestamps = const <IncidentStatus, DateTime>{},
  });

  final String id;
  final String referenceNumber;
  final String title;
  final String description;
  final IncidentCategory category;
  final IncidentLocation location;
  final IncidentPriority priority;
  final IncidentStatus status;
  final List<String> imageUrls;
  final String reportedBy;
  final String reporterName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? staffNote;
  final Map<IncidentStatus, DateTime> statusTimestamps;

  bool matchesQuery(String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) {
      return true;
    }
    final haystack = [
      title,
      referenceNumber,
      description,
      category.label,
      location.displayLabel,
      location.placeLabel,
      reporterName,
    ].join(' ').toLowerCase();
    return haystack.contains(needle);
  }

  Incident copyWith({
    String? id,
    String? referenceNumber,
    String? title,
    String? description,
    IncidentCategory? category,
    IncidentLocation? location,
    IncidentPriority? priority,
    IncidentStatus? status,
    List<String>? imageUrls,
    String? reportedBy,
    String? reporterName,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? staffNote,
    Map<IncidentStatus, DateTime>? statusTimestamps,
    bool clearStaffNote = false,
  }) {
    return Incident(
      id: id ?? this.id,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      imageUrls: imageUrls ?? this.imageUrls,
      reportedBy: reportedBy ?? this.reportedBy,
      reporterName: reporterName ?? this.reporterName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      staffNote: clearStaffNote ? null : staffNote ?? this.staffNote,
      statusTimestamps: statusTimestamps ?? this.statusTimestamps,
    );
  }

  @override
  List<Object?> get props => [
    id,
    referenceNumber,
    title,
    description,
    category,
    location,
    priority,
    status,
    imageUrls,
    reportedBy,
    reporterName,
    createdAt,
    updatedAt,
    staffNote,
    statusTimestamps,
  ];
}
