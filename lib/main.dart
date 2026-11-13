import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebase();
  runApp(const ProviderScope(child: CampusCareApp()));
}

/// Starts Firebase when native config exists.
/// Missing google-services / GoogleService-Info files must not block the app.
Future<void> _initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (error, stackTrace) {
    debugPrint('Firebase is not configured yet. Continuing without it.');
    debugPrint('$error');
    debugPrint('$stackTrace');
  }
}
