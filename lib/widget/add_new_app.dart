import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AddNewApp extends StatelessWidget {

  static const String title = "Monitora nuova app";
  final List<Application> appList;
  final Function(Application) addNewAppCallback;

  const AddNewApp({super.key, required this.appList, required this.addNewAppCallback});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text(title),
          elevation: 8,
          shadowColor: colorScheme.secondary,
        ),
      body: ListView.builder(
        itemCount: appList.length,
        itemBuilder: (context, idx) {
          return ListTile(
            title: Text(appList[idx].appName),
            onTap: () => addNewAppCallback(appList[idx]),
          );
        },
      )
    );
  }

}