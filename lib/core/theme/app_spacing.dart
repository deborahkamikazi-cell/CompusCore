/// Spacing, radius, and touch-target scale used by the theme and widgets.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;

  static const double cardRadius = 16;
  static const double buttonRadius = 14;
  static const double inputRadius = 12;

  static const double minTouchTarget = 48;
  static const double buttonHeight = 52;
  static const double thumbnail = minTouchTarget + xs;
  static const double logoMark = minTouchTarget + md;
  static const double wideLayout = 400;
}
