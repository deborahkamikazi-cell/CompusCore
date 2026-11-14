import 'package:campus_care/core/constants/app_strings.dart';

/// Time-of-day greeting. The home screen must not hardcode "Good morning".
String greetingFor(DateTime now) {
  final hour = now.hour;
  if (hour < 12) {
    return AppStrings.greetingMorning;
  }
  if (hour < 17) {
    return AppStrings.greetingAfternoon;
  }
  return AppStrings.greetingEvening;
}
