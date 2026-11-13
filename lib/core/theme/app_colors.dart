import 'package:material_ui/material_ui.dart';

/// Design tokens for CampusCare. Screens should use [ThemeData]; these
/// constants are the source of that theme.
abstract final class AppColors {
  static const Color navy = Color(0xFF0B1F4B);
  static const Color royalBlue = Color(0xFF2255D6);
  static const Color background = Color(0xFFF3F5F9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0B1F4B);
  static const Color textSecondary = Color(0xFF4A5778);
  static const Color border = Color(0xFFC9D1E0);

  static const Color resolvedBackground = Color(0xFFDDF3E6);
  static const Color resolvedText = Color(0xFF0F6B38);
  static const Color pendingBackground = Color(0xFFFDEBD3);
  static const Color pendingText = Color(0xFF8A4B08);
  static const Color inProgressBackground = Color(0xFFDEE8FD);
  static const Color inProgressText = Color(0xFF1B3FA6);
  static const Color urgentBackground = Color(0xFFFDE2E0);
  static const Color urgentText = Color(0xFFA3231A);
}
