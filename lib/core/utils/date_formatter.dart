import 'package:intl/intl.dart';

/// Display formatting for incident and notification timestamps.
abstract final class DateFormatter {
  static final DateFormat _date = DateFormat.yMMMd();
  static final DateFormat _dateTime = DateFormat.yMMMd().add_jm();
  static final DateFormat _dayMonth = DateFormat('d MMM');
  static final DateFormat _dayMonthYear = DateFormat('d MMM y');

  static String formatDate(DateTime date) => _date.format(date.toLocal());

  static String formatDateTime(DateTime date) =>
      _dateTime.format(date.toLocal());

  static String formatDayMonth(DateTime date) =>
      _dayMonth.format(date.toLocal());

  static String formatDayMonthYear(DateTime date) =>
      _dayMonthYear.format(date.toLocal());
}
