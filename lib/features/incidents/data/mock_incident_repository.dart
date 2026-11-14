import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/features/auth/data/mock_auth_repository.dart';
import 'package:campus_care/features/incidents/data/incident_repository.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

/// Stable ids used by navigation until lists are real.
abstract final class SampleIncidentIds {
  static const powerOutage = 'inc-0142';
  static const leakingPipe = powerOutage;
  static const brokenTap = 'inc-0138';
  static const wifiOutage = 'inc-0140';
  static const brokenChair = 'inc-0131';
}

class MockIncidentRepository implements IncidentRepository {
  MockIncidentRepository() : _items = List<Incident>.of(sampleIncidents);

  final List<Incident> _items;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  static final List<Incident> sampleIncidents = [
    _incident(
      id: SampleIncidentIds.brokenTap,
      referenceNumber: 'CC-2026-0138',
      title: 'Broken tap, Block B',
      description:
          'The washroom tap on floor 2 will not shut off. Water is pooling on the floor.',
      category: IncidentCategory.water,
      location: const IncidentLocation(
        building: 'Block B',
        floor: 'Floor 2',
        room: 'Washroom',
      ),
      priority: IncidentPriority.high,
      status: IncidentStatus.submitted,
      createdAt: DateTime.utc(2026, 11, 6, 8, 20),
    ),
    _incident(
      id: SampleIncidentIds.powerOutage,
      referenceNumber: 'CC-2026-0142',
      title: 'Power outage, Hostel 2',
      description:
          'The lights and sockets in Hostel 2 went out this afternoon. Room 214 and the corridor are completely dark.',
      category: IncidentCategory.electricity,
      location: const IncidentLocation(
        building: 'Hostel 2',
        floor: 'Floor 2',
        room: 'Room 214',
      ),
      priority: IncidentPriority.critical,
      status: IncidentStatus.inProgress,
      createdAt: DateTime.utc(2026, 11, 6, 16, 10),
      updatedAt: DateTime.utc(2026, 11, 7, 9, 40),
      staffNote: 'Facilities is on site and checking the floor board.',
      dates: [
        DateTime.utc(2026, 11, 6, 16, 10),
        DateTime.utc(2026, 11, 6, 18, 5),
        DateTime.utc(2026, 11, 7, 9, 40),
      ],
    ),
    _incident(
      id: SampleIncidentIds.wifiOutage,
      referenceNumber: 'CC-2026-0140',
      title: 'Wi-Fi down in library',
      description:
          'Students cannot connect to the campus network in the library reading room.',
      category: IncidentCategory.wifi,
      location: const IncidentLocation(
        building: 'Library',
        floor: 'Floor 1',
        room: 'Reading room',
      ),
      priority: IncidentPriority.medium,
      status: IncidentStatus.underReview,
      createdAt: DateTime.utc(2026, 11, 5, 11, 0),
      updatedAt: DateTime.utc(2026, 11, 5, 15, 30),
      dates: [
        DateTime.utc(2026, 11, 5, 11, 0),
        DateTime.utc(2026, 11, 5, 15, 30),
      ],
    ),
    _incident(
      id: SampleIncidentIds.brokenChair,
      referenceNumber: 'CC-2026-0131',
      title: 'Broken chair, Lab 3',
      description: 'A chair in Lab 3 has a cracked seat and cannot be used.',
      category: IncidentCategory.furniture,
      location: const IncidentLocation(
        building: 'Lab 3',
        floor: 'Floor 1',
        room: 'Lab 3',
      ),
      priority: IncidentPriority.low,
      status: IncidentStatus.resolved,
      createdAt: DateTime.utc(2026, 10, 28, 10, 15),
      updatedAt: DateTime.utc(2026, 10, 30, 14, 0),
      staffNote: 'Chair replaced.',
      dates: [
        DateTime.utc(2026, 10, 28, 10, 15),
        DateTime.utc(2026, 10, 28, 16, 0),
        DateTime.utc(2026, 10, 29, 9, 0),
        DateTime.utc(2026, 10, 30, 14, 0),
      ],
    ),
    _incident(
      id: 'inc-0136',
      referenceNumber: 'CC-2026-0136',
      title: 'Overflowing bin, Cafeteria',
      description: 'The cafeteria bin by the entrance is overflowing onto the walkway.',
      category: IncidentCategory.sanitation,
      location: const IncidentLocation(
        building: 'Cafeteria',
        floor: 'Ground floor',
        room: 'Entrance',
      ),
      priority: IncidentPriority.medium,
      status: IncidentStatus.submitted,
      createdAt: DateTime.utc(2026, 11, 4, 12, 45),
    ),
    _incident(
      id: 'inc-0134',
      referenceNumber: 'CC-2026-0134',
      title: 'Loose railing, Block A',
      description: 'The stair railing on Block A moves when held and feels unsafe.',
      category: IncidentCategory.safety,
      location: const IncidentLocation(
        building: 'Block A',
        floor: 'Stairwell',
        room: 'East stairs',
      ),
      priority: IncidentPriority.high,
      status: IncidentStatus.inProgress,
      createdAt: DateTime.utc(2026, 11, 3, 8, 5),
      updatedAt: DateTime.utc(2026, 11, 4, 10, 20),
      dates: [
        DateTime.utc(2026, 11, 3, 8, 5),
        DateTime.utc(2026, 11, 3, 13, 0),
        DateTime.utc(2026, 11, 4, 10, 20),
      ],
    ),
    _incident(
      id: 'inc-0128',
      referenceNumber: 'CC-2026-0128',
      title: 'Flickering lights, Lecture Hall 1',
      description: 'The front row lights flicker throughout lectures.',
      category: IncidentCategory.electricity,
      location: const IncidentLocation(
        building: 'Lecture Hall 1',
        floor: 'Floor 1',
        room: 'Front row',
      ),
      priority: IncidentPriority.medium,
      status: IncidentStatus.resolved,
      createdAt: DateTime.utc(2026, 10, 20, 9, 0),
      updatedAt: DateTime.utc(2026, 10, 22, 11, 30),
      staffNote: 'Bulbs replaced.',
      dates: [
        DateTime.utc(2026, 10, 20, 9, 0),
        DateTime.utc(2026, 10, 20, 15, 0),
        DateTime.utc(2026, 10, 21, 9, 30),
        DateTime.utc(2026, 10, 22, 11, 30),
      ],
    ),
    _incident(
      id: 'inc-0133',
      referenceNumber: 'CC-2026-0133',
      title: 'No water, Hostel 1',
      description: 'Hostel 1 has had no running water since last night.',
      category: IncidentCategory.water,
      location: const IncidentLocation(
        building: 'Hostel 1',
        floor: 'Floor 1',
        room: 'Block entrance',
      ),
      priority: IncidentPriority.critical,
      status: IncidentStatus.underReview,
      createdAt: DateTime.utc(2026, 11, 2, 7, 10),
      updatedAt: DateTime.utc(2026, 11, 2, 9, 0),
      dates: [
        DateTime.utc(2026, 11, 2, 7, 10),
        DateTime.utc(2026, 11, 2, 9, 0),
      ],
    ),
    _incident(
      id: 'inc-0130',
      referenceNumber: 'CC-2026-0130',
      title: 'Damaged desk, Block C',
      description: 'A study desk in Block C has a broken drawer and a sharp edge.',
      category: IncidentCategory.furniture,
      location: const IncidentLocation(
        building: 'Block C',
        floor: 'Floor 3',
        room: 'Study bay',
      ),
      priority: IncidentPriority.low,
      status: IncidentStatus.submitted,
      createdAt: DateTime.utc(2026, 11, 1, 15, 25),
    ),
    _incident(
      id: 'inc-0139',
      referenceNumber: 'CC-2026-0139',
      title: 'Slippery floor, Library entrance',
      description: 'The library entrance floor is wet and slippery after cleaning.',
      category: IncidentCategory.safety,
      location: const IncidentLocation(
        building: 'Library',
        floor: 'Ground floor',
        room: 'Entrance',
      ),
      priority: IncidentPriority.high,
      status: IncidentStatus.inProgress,
      reportedBy: 'student-002',
      reporterName: 'David Mugisha',
      createdAt: DateTime.utc(2026, 11, 6, 13, 0),
      updatedAt: DateTime.utc(2026, 11, 6, 17, 15),
      dates: [
        DateTime.utc(2026, 11, 6, 13, 0),
        DateTime.utc(2026, 11, 6, 14, 30),
        DateTime.utc(2026, 11, 6, 17, 15),
      ],
    ),
  ];

  static Incident _incident({
    required String id,
    required String referenceNumber,
    required String title,
    required String description,
    required IncidentCategory category,
    required IncidentLocation location,
    required IncidentPriority priority,
    required IncidentStatus status,
    required DateTime createdAt,
    DateTime? updatedAt,
    String? staffNote,
    List<DateTime>? dates,
    String reportedBy = MockAuthRepository.deborahId,
    String reporterName = 'Deborah U.',
  }) {
    final stamps = <IncidentStatus, DateTime>{};
    final steps = dates ?? [createdAt];
    final currentIndex = IncidentStatus.values.indexOf(status);
    for (var index = 0; index <= currentIndex && index < steps.length; index++) {
      stamps[IncidentStatus.values[index]] = steps[index];
    }
    return Incident(
      id: id,
      referenceNumber: referenceNumber,
      title: title,
      description: description,
      category: category,
      location: location,
      priority: priority,
      status: status,
      reportedBy: reportedBy,
      reporterName: reporterName,
      createdAt: createdAt,
      updatedAt: updatedAt ?? createdAt,
      imageUrls: const [],
      staffNote: staffNote,
      statusTimestamps: stamps,
    );
  }

  void dispose() {
    _changes.close();
  }

  void _notify() {
    if (!_changes.isClosed) {
      _changes.add(null);
    }
  }

  @override
  Stream<List<Incident>> watchAll() async* {
    yield List<Incident>.unmodifiable(_sorted());
    await for (final _ in _changes.stream) {
      yield List<Incident>.unmodifiable(_sorted());
    }
  }

  @override
  Stream<List<Incident>> watchByReporter(String uid) async* {
    List<Incident> filtered() =>
        _sorted().where((incident) => incident.reportedBy == uid).toList();

    yield List<Incident>.unmodifiable(filtered());
    await for (final _ in _changes.stream) {
      yield List<Incident>.unmodifiable(filtered());
    }
  }

  List<Incident> _sorted() {
    final copy = List<Incident>.of(_items);
    copy.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return copy;
  }

  @override
  Future<Incident?> getById(String id) async {
    for (final incident in _items) {
      if (incident.id == id) {
        return incident;
      }
    }
    return null;
  }

  @override
  Future<Incident> create(Incident draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final now = DateTime.now().toUtc();
    final sequence = _nextSequence();
    final created = draft.copyWith(
      id: 'inc-$sequence',
      referenceNumber: 'CC-${now.year}-$sequence',
      status: IncidentStatus.submitted,
      createdAt: now,
      updatedAt: now,
      statusTimestamps: {IncidentStatus.submitted: now},
    );
    _items.insert(0, created);
    _notify();
    return created;
  }

  String _nextSequence() {
    var max = 150;
    for (final item in _items) {
      final parts = item.referenceNumber.split('-');
      final value = int.tryParse(parts.isEmpty ? '' : parts.last) ?? 0;
      if (value > max) {
        max = value;
      }
    }
    return (max + 1).toString().padLeft(4, '0');
  }

  @override
  Future<void> updateStatus({
    required String id,
    required IncidentStatus status,
    String? staffNote,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final index = _items.indexWhere((incident) => incident.id == id);
    if (index == -1) {
      return;
    }
    final current = _items[index];
    final now = DateTime.now().toUtc();
    final timestamps = Map<IncidentStatus, DateTime>.from(
      current.statusTimestamps,
    );
    final target = IncidentStatus.values.indexOf(status);
    for (var step = 0; step <= target; step++) {
      timestamps.putIfAbsent(IncidentStatus.values[step], () => now);
    }
    timestamps[status] = now;
    final note = staffNote?.trim();
    _items[index] = current.copyWith(
      status: status,
      staffNote: note == null || note.isEmpty ? current.staffNote : note,
      updatedAt: now,
      statusTimestamps: timestamps,
    );
    _notify();
  }
}

final incidentRepositoryProvider = Provider<IncidentRepository>((ref) {
  final repository = MockIncidentRepository();
  ref.onDispose(repository.dispose);
  return repository;
});
