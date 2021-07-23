import 'package:flutter/material.dart';

import './screens/auth_screens/auth_tabs_screen.dart';
import './screens/app_tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(229, 229, 229, 1),
        buttonColor: Color.fromRGBO(0, 88, 127, 1),
        accentColor: Color.fromRGBO(245, 245, 245, 1),
        bottomAppBarColor: Color.fromRGBO(33, 33, 33, 1),
        primaryTextTheme: TextTheme(
          headline2: TextStyle(
            fontSize: 45,
            color: Colors.black,
          ),
          headline1: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
      ),
      home: AuthTabsScreen(),
      initialRoute: "/",
      routes: {
        AppTabsScreen.routeName: (ctx) => AppTabsScreen(),
      },
    );
  }
}
