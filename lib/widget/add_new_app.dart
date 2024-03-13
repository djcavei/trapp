import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:trapp/model/usage_info_with_app_name.dart';

class AddNewApp extends StatefulWidget {
  final Function(UsageInfoWithAppName) addNewAppCallback;

  const AddNewApp({super.key, required this.addNewAppCallback});

  @override
  State<StatefulWidget> createState() => AddNewAppState();
}

class AddNewAppState extends State<AddNewApp> {
  final String title = "Monitora nuova app";
  late final Future<List<UsageInfoWithAppName>> _usageInfoWithAppNameList;

  @override
  void initState() {
    super.initState();
    UsageStats.grantUsagePermission(); // TODO cosa fa?
    _usageInfoWithAppNameList = _getUsageInfoWithAppName();
  }

  Future<List<UsageInfoWithAppName>> _getUsageInfoWithAppName() async {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = endDate.subtract(oneDay);
    final List<UsageInfo> usageInfos =
        await UsageStats.queryUsageStats(startDate, endDate);
    List<UsageInfoWithAppName> usageInfoWithAppNameList = [];
    bool includeAppIcon = true;
    for (UsageInfo usageInfo in usageInfos) {
      Application? application =
          await DeviceApps.getApp(usageInfo.packageName!, includeAppIcon);
      if (application != null) {
        usageInfoWithAppNameList.add(UsageInfoWithAppName(
            usageInfo: usageInfo,
            appName: application.appName,
            icon: (application as ApplicationWithIcon).icon));
      }
    }
    return usageInfoWithAppNameList;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(title),
        elevation: 8,
        shadowColor: colorScheme.secondary,
      ),
      body: FutureBuilder(
          future: _usageInfoWithAppNameList,
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                    title: Text(snapshot.data![idx].appName),
                    onTap: () => widget.addNewAppCallback(snapshot.data![idx]),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: Column(children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Errore'),
                )
              ]));
            } else {
              return const Center(
                  child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Caricamento risultati...'),
                )
              ]));
            }
          }),
    );
  }
}
