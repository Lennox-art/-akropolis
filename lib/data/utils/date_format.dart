import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String get commentDateTime => DateFormat("h:mm a · MMM d, y").format(this);
  String get chatTime {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(year, month, day);
    final time24hr = DateFormat('HH:mm').format(this);

    // If today
    if (messageDate == today) return time24hr;

    //If yesterday
    if(now.difference(messageDate).inDays == 1) return "Yesterday $time24hr";

    // If this week
    if (now.difference(messageDate).inDays < 7) return '${DateFormat('EEEE').format(this)} $time24hr';

    // If this year
    if (year == now.year) return '${DateFormat('d MMM').format(this)} $time24hr';

    return '${DateFormat('d MMM yyyy').format(this)} $time24hr';
  }
}