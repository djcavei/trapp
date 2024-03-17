import 'package:trapp/constants.dart';

List<int> hoursMinutesSecondsFromMillis(String? millis) {
  var duration = Duration(milliseconds: int.parse(millis ?? "0"));
  return [
    duration.inHours,
    duration.inMinutes % minutesInAnHour,
    duration.inSeconds % secondsInAMinute
  ];
}