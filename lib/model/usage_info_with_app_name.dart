import 'dart:typed_data';

import 'package:usage_stats/usage_stats.dart';

class UsageInfoWithAppName {
  final UsageInfo usageInfo;
  final String appName;
  final Uint8List icon;
  UsageInfoWithAppName({required this.usageInfo, required this.appName, required this.icon});
}