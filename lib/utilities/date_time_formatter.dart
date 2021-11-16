import 'package:intl/intl.dart';

class DateTimeFormatter {
  String toClockTime(DateTime time) {
    return DateFormat.Hms().format(time);
  }
}
