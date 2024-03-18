import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:trapp/functions/functions.dart';
import 'package:trapp/model/custom_usage_info.dart';
import 'package:trapp/utils/date_utils.dart';

import '../common/buttons.dart';

class AppStats extends StatefulWidget {
  const AppStats({super.key});

  @override
  State<StatefulWidget> createState() => AppStatsState();
}

class AppStatsState extends State<AppStats> {
  final List<CustomUsageInfo> monitoredApps = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: appStatsListViewBuilder, itemCount: monitoredApps.length);
  }

  ListTile appStatsListViewBuilder(BuildContext context, int index) {
    return ListTile(
      leading: const Icon(Icons.adb_sharp),
      title: Text(monitoredApps[index].appName, style: defaultListTileTextStyle),
      subtitle: Text(getDurationStringFromMillis(monitoredApps[index].totalTimeInForeground)),
      onTap: () => openRemoveDialog(index),
    );
  }

  openRemoveDialog(int index) {
    showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              title: Text(
                  "Vuoi rimuovere l'app ${monitoredApps[index].appName} dal monitoraggio?"),
              actions: [
                ConfirmButtonWithCallback(
                    voidCallback: () => removeMonitoredApp(index)),
                const SizedBox(width: 50),
                CancelButton(context: context)
              ],
              actionsAlignment: MainAxisAlignment.center,
            ));
  }

  addMonitoredApp(CustomUsageInfo usageInfoWithAppName) {
    setState(() {
      monitoredApps.add(usageInfoWithAppName);
    });
  }

  removeMonitoredApp(int index) {
    setState(() {
      monitoredApps.removeAt(index);
    });
    Navigator.of(context).pop();
  }

  String getDurationStringFromMillis(String? totalTimeInForeground) {
    final List<int> hoursMinutesSeconds = hoursMinutesSecondsFromMillis(totalTimeInForeground);
    final int hours = hoursMinutesSeconds[0];
    final int minutes = hoursMinutesSeconds[1];
    final int seconds = hoursMinutesSeconds[2];
    return "${hours}h ${minutes}m ${seconds}s";
  }

}
