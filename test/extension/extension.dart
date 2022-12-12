extension IntExt on int {
  String padLeft(int width, [String padding = '0']) {
    return toString().padLeft(width, padding);
  }
}

extension StrExt on DateTime {
  String convertAppApiDateTimeToString() {
    final dateText = '${year.padLeft(4)}-${month.padLeft(2)}-${day.padLeft(2)}';
    final timeText =
        '${hour.padLeft(2)}:${minute.padLeft(2)}:${second.padLeft(2)}';

    final timeZoneOffset = this.timeZoneOffset;
    final timeZoneSign = timeZoneOffset.isNegative ? '-' : '+';
    final timeZoneText = '$timeZoneSign${timeZoneOffset.inHours.padLeft(2)}:00';

    return '${dateText}T$timeText$timeZoneText';
  }
}
