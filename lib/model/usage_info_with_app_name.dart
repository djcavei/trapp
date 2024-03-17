import 'dart:typed_data';

import 'package:usage_stats/usage_stats.dart';

class UsageInfoWithAppName {
  final UsageInfo usageInfo;
  final String appName;
  final Uint8List icon;

  UsageInfoWithAppName({required this.usageInfo, required this.appName, required this.icon});

}

class UsageInfoWithAppNameBuilder {
  late UsageInfo _usageInfo;
  late String _appName;
  late Uint8List _icon;

  get usageInfo => _usageInfo;

  UsageInfoWithAppNameBuilder setUsageInfo(UsageInfo usageInfo) {
    _usageInfo = usageInfo;
    return this;
  }

  UsageInfoWithAppNameBuilder setAppName(String appName) {
    _appName = appName;
    return this;
  }

  UsageInfoWithAppNameBuilder setIcon(Uint8List icon) {
    _icon = icon;
    return this;
  }

  UsageInfoWithAppName build() {
    return UsageInfoWithAppName(usageInfo: _usageInfo, appName: _appName, icon: _icon);
  }

  @override
  bool operator ==(Object other) {
    return other is UsageInfoWithAppNameBuilder &&
        _usageInfo.packageName == other.usageInfo.packageName;
  }

  @override
  int get hashCode => _usageInfo.packageName.hashCode;
}