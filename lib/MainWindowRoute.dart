import 'package:flutter/material.dart';

import 'AboutRoute.dart';
import 'LogHistoryRoute.dart';
import 'LogMealRoute.dart';

class MainWindowRoute extends StatefulWidget {
  @override
  State<MainWindowRoute> createState() => _MainWindowRouteState();
}

class _MainWindowRouteState extends State<MainWindowRoute> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Food Log'),
                ),
                ListTile(
                  title: const Text('About'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutRoute()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.fastfood), text: "Add meal"),
                Tab(icon: Icon(Icons.history), text: "History"),
              ],
            ),
            title: const Text('Food Log'),
          ),
          body: const TabBarView(
            children: [
              LogMealRoute(),
              LogHistoryRoute(),
            ],
          ),
        ),
      ),
    );
  }
}
