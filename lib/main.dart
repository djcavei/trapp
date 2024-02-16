import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    Column(
      key: GlobalKey(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: GlobalKey(),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
      ],
    ),
    Column(
      key: GlobalKey(),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    ),
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
        elevation: 8,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.secondary,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 26,
        ),
      ),
    );
  }

  void _onItemSelected(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }
}
