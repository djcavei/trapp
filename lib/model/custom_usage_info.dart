import 'dart:math';
import 'dart:typed_data';

import 'package:usage_stats/usage_stats.dart';

class CustomUsageInfo {
  final String packageName;
  final String totalTimeInForeground;
  final String lastTimeUsed;
  final String appName;
  final Uint8List icon;

  CustomUsageInfo(
      {required this.packageName,
      required this.totalTimeInForeground,
      required this.lastTimeUsed,
      required this.appName,
      required this.icon});
}


class CustomUsageInfoBuilder {
  final String packageName;
  late num totalTimeInForeground;
  late num lastTimeUsed;
  late String appName;
  late Uint8List icon;
  
  CustomUsageInfoBuilder(this.packageName, this.totalTimeInForeground, this.lastTimeUsed);
  
  void updateStats(UsageInfo newUsageInfo) {
    totalTimeInForeground = totalTimeInForeground + int.parse(newUsageInfo.totalTimeInForeground!);
    lastTimeUsed = max(lastTimeUsed, int.parse(newUsageInfo.lastTimeUsed!));
  }

  void setAppName(String appName) {
    this.appName = appName;
  }
  void setIcon(Uint8List icon) {
    this.icon = icon;
  }
  
  CustomUsageInfo build() {
    return CustomUsageInfo(packageName: packageName, totalTimeInForeground: "$totalTimeInForeground", lastTimeUsed: "$lastTimeUsed", appName: appName, icon: icon);
  }

}