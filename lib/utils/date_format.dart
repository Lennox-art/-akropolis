import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String get commentDateTime => DateFormat("h:mm a · MMM d, y").format(this);
}