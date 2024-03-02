import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:trapp/functions/functions.dart';

class AppStats extends StatefulWidget {
  const AppStats({super.key});

  @override
  State<StatefulWidget> createState() => AppStatsState();
}

class AppStatsState extends State<AppStats> {
  final List<Application> monitoredApps = [];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
    var colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
          "Vuoi rimuovere l'app ${monitoredApps[index].appName} dal monitoraggio?"),
      actions: [
        TextButton(
            style: ButtonStyle(
                backgroundColor: getErrorBackground(context),
                foregroundColor: getErrorForeground(context)),
            onPressed: () => removeMonitoredApp(index),
            child: const Text("Si")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"))
      ],
    );
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
  }
}
