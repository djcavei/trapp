import 'package:trapp/constants.dart';

List<int> hoursMinutesSecondsFromMillis(int millis) {
  var duration = Duration(milliseconds: millis);
  return [
    duration.inHours,
    duration.inMinutes % minutesInAnHour,
    duration.inSeconds % secondsInAMinute
  ];
}