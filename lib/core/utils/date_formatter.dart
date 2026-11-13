import 'package:intl/intl.dart';

/// Display formatting for incident and notification timestamps.
abstract final class DateFormatter {
  static final DateFormat _date = DateFormat.yMMMd();
  static final DateFormat _dateTime = DateFormat.yMMMd().add_jm();

  static String formatDate(DateTime date) => _date.format(date.toLocal());

  static String formatDateTime(DateTime date) =>
      _dateTime.format(date.toLocal());
}
