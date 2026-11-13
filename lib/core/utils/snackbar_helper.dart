import 'package:material_ui/material_ui.dart';

/// Thin wrapper so features do not call [ScaffoldMessenger] directly.
abstract final class SnackbarHelper {
  static void show(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
