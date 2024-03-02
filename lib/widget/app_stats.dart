import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:trapp/functions/functions.dart';

import '../common/buttons.dart';

class AppStats extends StatefulWidget {
  const AppStats({super.key});

  @override
  State<StatefulWidget> createState() => AppStatsState();
}

class AppStatsState extends State<AppStats> {
  final List<Application> monitoredApps = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: appStatsListViewBuilder, itemCount: monitoredApps.length);
  }

  ListTile appStatsListViewBuilder(BuildContext context, int index) {
    return ListTile(
      title: Text(monitoredApps[index].appName),
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

  addMonitoredApp(Application application) {
    setState(() {
      monitoredApps.add(application);
    });
  }

  removeMonitoredApp(int index) {
    setState(() {
      monitoredApps.removeAt(index);
    });
    Navigator.of(context).pop();
  }
}
