import 'dart:collection';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:trapp/constants.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:trapp/model/custom_usage_info.dart';

import '../common/error_screen.dart';
import '../common/loading_screen.dart';

class AddNewApp extends StatefulWidget {
  final Function(CustomUsageInfo) addNewAppCallback;

  const AddNewApp({super.key, required this.addNewAppCallback});

  @override
  State<StatefulWidget> createState() => AddNewAppState();
}

class AddNewAppState extends State<AddNewApp> {
  final String title = "Monitora nuova app";
  late final Future<List<CustomUsageInfo>> _usageInfoWithAppNameList;

  @override
  void initState() {
    super.initState();
    UsageStats.grantUsagePermission(); // TODO cosa fa?
    _usageInfoWithAppNameList = _getUsageInfoWithAppName();
  }

  Future<List<CustomUsageInfo>> _getUsageInfoWithAppName() async {
    final DateTime endDate = DateTime.now();
    final DateTime startDate = endDate.subtract(oneDay);
    final List<UsageInfo> usageInfos = await UsageStats.queryUsageStats(
        startDate,
        endDate);
    
    Map<String, CustomUsageInfoBuilder> packageNameCustomUsageInfoBuilderMap = HashMap();
    
    for (UsageInfo ui in usageInfos) {
      packageNameCustomUsageInfoBuilderMap
          .putIfAbsent(ui.packageName!,
              () => CustomUsageInfoBuilder(ui.packageName!, int.parse(ui.totalTimeInForeground!), int.parse(ui.lastTimeUsed!)))
          .updateStats(ui);
    }
    
    final List<CustomUsageInfo> customUsageInfoList = [];
    const bool includeAppIcon = true;

    for(var mapEntry in packageNameCustomUsageInfoBuilderMap.entries) {
      var application = await DeviceApps.getApp(mapEntry.key, includeAppIcon);
      if(application != null) {
        mapEntry.value.setAppName(application.appName);
        mapEntry.value.setIcon((application as ApplicationWithIcon).icon);
        customUsageInfoList.add(mapEntry.value.build());
      }
    }

    customUsageInfoList.sort((a, b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase()));
    return customUsageInfoList;

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
      AsyncSnapshot<List<CustomUsageInfo>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, idx) {
        return ListTile(
          leading: const Icon(Icons.adb_sharp), // todo le icone
          title: Text(snapshot.data![idx].appName,
              style: defaultListTileTextStyle),
          onTap: () => widget.addNewAppCallback(snapshot.data![idx]),
        );
      },
    );
  }
}
