/// Firestore collection paths and Storage object paths.
///
/// Collections: `users/{uid}`, `incidents/{incidentId}`, `notifications/{id}`.
/// Storage: `incident_images/{incidentId}/{fileName}`.
abstract final class FirestorePaths {
  static const users = 'users';
  static const incidents = 'incidents';
  static const notifications = 'notifications';

  static String user(String uid) => '$users/$uid';

  static String incident(String incidentId) => '$incidents/$incidentId';

  static String notification(String id) => '$notifications/$id';
}

abstract final class StoragePaths {
  static const incidentImages = 'incident_images';

  static String incidentImage(String incidentId, String fileName) =>
      '$incidentImages/$incidentId/$fileName';
}
