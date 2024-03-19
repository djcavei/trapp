import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:trapp/functions/functions.dart';
import 'package:trapp/model/custom_usage_info.dart';
import 'package:trapp/utils/date_utils.dart';

import '../common/buttons.dart';
import '../common/default_list_tile_divider.dart';

class AppStats extends StatefulWidget {
  const AppStats({super.key});

  @override
  State<StatefulWidget> createState() => AppStatsState();
}

class AppStatsState extends State<AppStats> {
  final List<CustomUsageInfo> monitoredApps = [];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, idx) {
          return const DefaultListTileDivider();
        },
        itemBuilder: appStatsListViewBuilder, itemCount: monitoredApps.length);
  }

  ListTile appStatsListViewBuilder(BuildContext context, int index) {
    return ListTile(
      leading: const Icon(Icons.adb_sharp),
      title: Text(monitoredApps[index].appName, style: defaultListTileTextStyle),
      subtitle: Text(getAppUsageSummary(index)),
      onTap: () => openRemoveDialog(index),
    );
  }

  String getAppUsageSummary(int index) {
    List<int> hoursMinutesSecondsOfUsage = getHoursMinutesSecondsOfUsage(monitoredApps[index].totalTimeInForeground);
    DateTime lastTimestampOfUsage = getLastTimestampOfForeground(monitoredApps[index].lastTimeUsed);
    var res = "Utilizzo totale ${hoursMinutesSecondsOfUsage[0]}h ${hoursMinutesSecondsOfUsage[1]}m ${hoursMinutesSecondsOfUsage[2]}s";
    if(lastTimestampOfUsage.year != 1970) {
      res += "\nUltimo accesso ${getTodayOrYesterdayOrDate(lastTimestampOfUsage)} alle ${lastTimestampOfUsage.hour}:${lastTimestampOfUsage.minute}";
    }
    return res;
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

    List<int> getHoursMinutesSecondsOfUsage(int totalTimeInForeground) {
      return hoursMinutesSecondsFromMillis(totalTimeInForeground);
    }

    DateTime getLastTimestampOfForeground(int lastTimeUsed) {
      return DateTime.fromMillisecondsSinceEpoch(lastTimeUsed);
    }

  String getTodayOrYesterdayOrDate(DateTime lastTimestampOfUsage) {
    var now = DateTime.now();
    var yesterday = now.subtract(const Duration(days: 1));
    if(lastTimestampOfUsage.year == now.year && lastTimestampOfUsage.month == now.month && lastTimestampOfUsage.day == now.day) {
      return "oggi";
    } else if(lastTimestampOfUsage.year == yesterday.year && lastTimestampOfUsage.month == yesterday.month && lastTimestampOfUsage.day == yesterday.day) {
      return "ieri";
    } else {
      var year = now.year != lastTimestampOfUsage.year ? "/${lastTimestampOfUsage.year}" : "";
      return "${lastTimestampOfUsage.day}/${lastTimestampOfUsage.month}$year";
    }

  }

}
