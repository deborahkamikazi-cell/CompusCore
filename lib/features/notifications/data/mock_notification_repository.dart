import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/features/auth/data/mock_auth_repository.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';
import 'package:campus_care/features/notifications/data/notification_repository.dart';
import 'package:campus_care/features/notifications/domain/app_notification.dart';

class MockNotificationRepository implements NotificationRepository {
  static final List<AppNotification> samples = [
    AppNotification(
      id: 'note-1',
      userId: MockAuthRepository.deborahId,
      title: 'Report in progress',
      body: 'Power outage, Hostel 2 is now in progress.',
      createdAt: DateTime.utc(2026, 11, 7, 9, 40),
      incidentId: 'inc-0142',
    ),
    AppNotification(
      id: 'note-2',
      userId: MockAuthRepository.deborahId,
      title: 'Report under review',
      body: 'Wi-Fi down in library is under review.',
      createdAt: DateTime.utc(2026, 11, 5, 15, 30),
      incidentId: 'inc-0140',
    ),
    AppNotification(
      id: 'note-3',
      userId: MockAuthRepository.deborahId,
      title: 'Report resolved',
      body: 'Broken chair, Lab 3 has been resolved.',
      createdAt: DateTime.utc(2026, 10, 30, 14, 0),
      incidentId: 'inc-0131',
    ),
  ];

  @override
  Stream<List<AppNotification>> watchForUser(String uid) async* {
    yield samples.where((item) => item.userId == uid).toList();
  }

  @override
  Future<void> markRead(String id) async {}
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return MockNotificationRepository();
});

final notificationsProvider = StreamProvider<List<AppNotification>>((ref) {
  final user = ref.watch(authControllerProvider).user;
  if (user == null) {
    return Stream.value(const []);
  }
  return ref.watch(notificationRepositoryProvider).watchForUser(user.uid);
});

final unreadNotificationCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).maybeWhen(
    data: (items) => items.where((item) => !item.isRead).length,
    orElse: () => 0,
  );
});
