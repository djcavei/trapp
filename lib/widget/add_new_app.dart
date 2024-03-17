import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:trapp/model/usage_info_with_app_name.dart';

import '../common/error_screen.dart';
import '../common/loading_screen.dart';

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
    final List<UsageInfo> usageInfos = await UsageStats.queryUsageStats(
        startDate,
        endDate); // todo ricorda di capire xk tra i tanti package alcuni hanno piu tempo altri zero
    List<UsageInfoWithAppNameBuilder> usageInfoBuilderList =
        usageInfos.map((ui) => UsageInfoWithAppNameBuilder().setUsageInfo(ui)).toSet().toList();
    bool includeAppIcon = true;
    final List<UsageInfoWithAppName> usageInfoWithAppNameList = [];
    for (UsageInfoWithAppNameBuilder usageInfoBuilder in usageInfoBuilderList) {
      Application? application = await DeviceApps.getApp(
          usageInfoBuilder.usageInfo.packageName!, includeAppIcon);
      if (application != null) {
        usageInfoWithAppNameList.add(UsageInfoWithAppName(
            usageInfo: usageInfoBuilder.usageInfo,
            appName: application.appName,
            icon: (application as ApplicationWithIcon).icon));
      }
    }
    usageInfoWithAppNameList.sort((a, b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase()));
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
              return _getApplicationListView(snapshot);
            } else if (snapshot.hasError) {
              return const ErrorScreen();
            } else {
              return const LoadingScreen();
            }
          }),
    );
  }

  ListView _getApplicationListView(
      AsyncSnapshot<List<UsageInfoWithAppName>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, idx) {
        return ListTile(
          leading: const Icon(Icons.adb_sharp), // todo le icone
          title: Text(snapshot.data![idx].appName!,
              style: defaultListTileTextStyle),
          onTap: () => widget.addNewAppCallback(snapshot.data![idx]),
        );
      },
    );
  }
}
