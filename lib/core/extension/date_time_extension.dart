extension DatetimeExtension on DateTime {
  /// for gettint timerAgoSince [DateTime]
  String timeAgoSinceDate() {
    final difference = DateTime.now().difference(this);
    if (difference.inDays >= 360) {
      return '1 year ago';
    } else if (difference.inDays >= 180) {
      return '6 month ago';
    } else if (difference.inDays >= 90) {
      return '3 month ago';
    } else if (difference.inDays >= 60) {
      return '2 month ago';
    } else if (difference.inDays >= 30) {
      return 'a month ago';
    } else if ((difference.inDays / 7).floor() >= 4) {
      return '4w ago';
    } else if ((difference.inDays / 7).floor() >= 3) {
      return '3w ago';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '2w ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '1w ago';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return '1 day ago';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}h ago';
    } else if (difference.inHours >= 1) {
      return '1h ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inMinutes >= 1) {
      return '1m ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s ago';
    } else {
      return 'Just now';
    }
  }
}
