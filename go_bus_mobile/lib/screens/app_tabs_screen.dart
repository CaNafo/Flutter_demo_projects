import 'package:flutter/material.dart';
import 'package:go_bus_mobile/providers/home_screen_provider.dart';
import 'package:provider/provider.dart';

import '../screens/map_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class AppTabsScreen extends StatefulWidget {
  static const routeName = '/app-screens';
  @override
  _AppTabsScreenState createState() => _AppTabsScreenState();
}

class _AppTabsScreenState extends State<AppTabsScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
    );
    return ChangeNotifierProvider(
      create: (context) => HomeScreenProvider(),
      child: Scaffold(
        appBar: appBar,
        body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).bottomAppBarColor,
          selectedItemColor: Theme.of(context).buttonColor,
          currentIndex: _selectedScreenIndex,
          type: BottomNavigationBarType.shifting,
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).accentColor,
          elevation: 5,
          items: [
            const BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Početna",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.map),
              label: "Mapa",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: "Pregled",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: "Podešavanja",
            ),
          ],
        ),
      ),
    );
  }
}
