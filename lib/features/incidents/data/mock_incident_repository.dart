import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/features/incidents/data/incident_repository.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

/// Stable ids used by placeholder navigation until lists are real.
abstract final class SampleIncidentIds {
  static const leakingPipe = 'inc-0142';
  static const wifiOutage = 'inc-0143';
  static const brokenChair = 'inc-0144';
}

class MockIncidentRepository implements IncidentRepository {
  MockIncidentRepository() : _items = List<Incident>.of(sampleIncidents);

  final List<Incident> _items;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  static final List<Incident> sampleIncidents = [
    Incident(
      id: SampleIncidentIds.leakingPipe,
      referenceNumber: 'CC-2026-0142',
      title: 'Leaking pipe in Block B',
      description: 'Water is pooling outside the second-floor bathrooms.',
      category: IncidentCategory.water,
      location: const IncidentLocation(
        building: 'Block B',
        floor: '2',
        room: 'Washrooms',
      ),
      priority: IncidentPriority.high,
      status: IncidentStatus.submitted,
      imageUrls: const [],
      reportedBy: 'student-001',
      reporterName: 'Amina Uwase',
      createdAt: DateTime.utc(2026, 3, 2, 9, 15),
      updatedAt: DateTime.utc(2026, 3, 2, 9, 15),
    ),
    Incident(
      id: SampleIncidentIds.wifiOutage,
      referenceNumber: 'CC-2026-0143',
      title: 'Wi-Fi down in the library',
      description: 'Students cannot connect to the campus network.',
      category: IncidentCategory.wifi,
      location: const IncidentLocation(
        building: 'Library',
        floor: '1',
        room: 'Reading room',
      ),
      priority: IncidentPriority.critical,
      status: IncidentStatus.inProgress,
      imageUrls: const [],
      reportedBy: 'student-002',
      reporterName: 'David Mugisha',
      createdAt: DateTime.utc(2026, 3, 1, 14, 0),
      updatedAt: DateTime.utc(2026, 3, 3, 8, 40),
      staffNote: 'Network team is on site.',
    ),
    Incident(
      id: SampleIncidentIds.brokenChair,
      referenceNumber: 'CC-2026-0144',
      title: 'Broken chair in lecture hall',
      description: 'A chair in row C has a cracked seat.',
      category: IncidentCategory.furniture,
      location: const IncidentLocation(
        building: 'Academic Block',
        floor: '1',
        room: 'LH-3',
      ),
      priority: IncidentPriority.low,
      status: IncidentStatus.resolved,
      imageUrls: const [],
      reportedBy: 'student-001',
      reporterName: 'Amina Uwase',
      createdAt: DateTime.utc(2026, 2, 20, 11, 5),
      updatedAt: DateTime.utc(2026, 2, 21, 16, 30),
      staffNote: 'Chair replaced.',
    ),
  ];

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
    yield List<Incident>.unmodifiable(_items);
    await for (final _ in _changes.stream) {
      yield List<Incident>.unmodifiable(_items);
    }
  }

  @override
  Stream<List<Incident>> watchByReporter(String uid) async* {
    List<Incident> filtered() =>
        _items.where((incident) => incident.reportedBy == uid).toList();

    yield List<Incident>.unmodifiable(filtered());
    await for (final _ in _changes.stream) {
      yield List<Incident>.unmodifiable(filtered());
    }
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
    final now = DateTime.now().toUtc();
    final sequence = 1000 + _items.length + 1;
    final created = draft.copyWith(
      id: 'inc-$sequence',
      referenceNumber: 'CC-${now.year}-$sequence',
      status: IncidentStatus.submitted,
      createdAt: now,
      updatedAt: now,
    );
    _items.insert(0, created);
    _notify();
    return created;
  }

  @override
  Future<void> updateStatus({
    required String id,
    required IncidentStatus status,
    String? staffNote,
  }) async {
    final index = _items.indexWhere((incident) => incident.id == id);
    if (index == -1) {
      return;
    }
    _items[index] = _items[index].copyWith(
      status: status,
      staffNote: staffNote,
      updatedAt: DateTime.now().toUtc(),
    );
    _notify();
  }
}

final incidentRepositoryProvider = Provider<IncidentRepository>((ref) {
  final repository = MockIncidentRepository();
  ref.onDispose(repository.dispose);
  return repository;
});
