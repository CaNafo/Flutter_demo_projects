import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../screens/map_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/questions_answers_screen.dart';
import '../providers/home_screen_provider.dart';
import '../providers/QA_provider.dart';
import '../providers/settings_provider.dart';

class AppTabsScreen extends StatefulWidget {
  static const routeName = '/app-screens';
  @override
  _AppTabsScreenState createState() => _AppTabsScreenState();
}

class _AppTabsScreenState extends State<AppTabsScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    // MapScreen(),
    QuestionsAnswersScreen(),
    SettingsScreen(),
  ];
  int _selectedScreenIndex = 1;

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeScreenProvider(),
        ),
        ChangeNotifierProvider.value(
          value: QAProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SettingsProvider(),
        ),
      ],
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
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              activeIcon: const Icon(Icons.home_outlined),
              label: AppLocalizations.of(context).home_bottom_tab,
            ),
            // BottomNavigationBarItem(
            //   icon: const Icon(Icons.map),
            //   activeIcon: const Icon(Icons.map_outlined),
            //   label: AppLocalizations.of(context).map_bottom_tab,
            // ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.question_answer),
              activeIcon: const Icon(Icons.question_answer_outlined),
              label: AppLocalizations.of(context).qa_bottom_tab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              activeIcon: const Icon(Icons.settings_outlined),
              label: AppLocalizations.of(context).settings_bottom_tab,
            ),
          ],
        ),
      ),
    );
  }
}
