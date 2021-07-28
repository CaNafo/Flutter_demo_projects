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
              activeIcon: const Icon(Icons.home_outlined),
              label: "Početna",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.map),
              activeIcon: const Icon(Icons.map_outlined),
              label: "Mapa",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.question_answer),
              activeIcon: const Icon(Icons.question_answer_outlined),
              label: "Q&A",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              activeIcon: const Icon(Icons.settings_outlined),
              label: "Podešavanja",
            ),
          ],
        ),
      ),
    );
  }
}
