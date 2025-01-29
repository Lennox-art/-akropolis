
/// Converts `DateTime` to a "time ago" string
String timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours}h ago";
  } else {
    return "${difference.inDays}d ago";
  }
}