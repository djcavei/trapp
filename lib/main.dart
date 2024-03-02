import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trapp/constants.dart';
import 'package:trapp/widget/app_rules.dart';
import 'package:trapp/widget/app_stats.dart';
import 'package:trapp/widget/bottom_buttons.dart';
import 'package:trapp/widget/add_new_app.dart';

import 'functions/functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Trapp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            backgroundColor: Colors.white70,
            primarySwatch: Colors.orange,
            accentColor: Colors.lime,
            errorColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Trapp home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Widget> _widgets = <Widget>[
    AppStats(key: GlobalKey()),
    AppRules()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context)
        .colorScheme; // todo capisci diff tra const e final in flutter
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
        elevation: appBarElevation,
        shadowColor: colorScheme.secondary,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: colorScheme.primary,
        indicatorColor: Colors.black12,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemSelected,
        destinations: const <Widget>[
          NavigationDestination(
              selectedIcon: Icon(Icons.bar_chart),
              icon: Icon(Icons.bar_chart_outlined),
              label: "Stats"),
          NavigationDestination(
              selectedIcon: Icon(Icons.straighten),
              icon: Icon(Icons.straighten_outlined),
              label: "Rules"),
        ],
        elevation: 8,
        shadowColor: colorScheme.primary,
      ),
      body: Center(
        child: _widgets.elementAt(_selectedIndex),
      ),
      floatingActionButton: BottomButtons(
          openMonitorNewAppCallback: () => _openMonitorNewApp(context)),
    );
  }

  void _onItemSelected(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  void _openMonitorNewApp(BuildContext context) async {
    final List<Application> appList = await DeviceApps.getInstalledApplications(
        includeAppIcons: true); // todo non funziona
    appList.sort(appNameComparator); // todo non mi piace
    if (context.mounted) {
      // todo capire xk è una bad practice
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNewApp(
                  key: UniqueKey(),
                  appList: appList,
                  addNewAppCallback: (app) {
                    getAppStatsWidgetState().addMonitoredApp(app);
                    Navigator.pop(context);
                  })));
    }
  }

  AppStatsState getAppStatsWidgetState() {
    return (_widgets.firstWhere((element) => element is AppStats).key
            as GlobalKey)
        .currentState! as AppStatsState;
  }

/*getAppRulesWidgetState() {
    (_widgets.firstWhere((element) => element is AppRules).key as GlobalKey<AppRulesState>).currentState;
  }*/
}
