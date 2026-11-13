import 'package:campus_care/features/notifications/domain/app_notification.dart';

/// Notification persistence. Firestore implementation comes in a later phase.
abstract class NotificationRepository {
  Stream<List<AppNotification>> watchForUser(String uid);

  Future<void> markRead(String id);
}
