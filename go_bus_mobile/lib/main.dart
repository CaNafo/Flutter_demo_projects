import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth_provider.dart';
import './screens/auth_screens/auth_tabs_screen.dart';
import './screens/app_tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            backgroundColor: Color.fromRGBO(229, 229, 229, 1),
            primarySwatch: Colors.blue,
            primaryColor: Color.fromRGBO(229, 229, 229, 1),
            buttonColor: Color.fromRGBO(0, 88, 127, 1),
            accentColor: Color.fromRGBO(245, 245, 245, 1),
            bottomAppBarColor: Color.fromRGBO(33, 33, 33, 1),
            primaryTextTheme: TextTheme(
              headline2: const TextStyle(
                fontSize: 45,
                color: Colors.black,
              ),
              headline1: const TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
          ),
          home: authProvider.isAuth
              ? AppTabsScreen()
              : FutureBuilder(
                  future: authProvider.tryAutoLogin(),
                  builder: (context, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? const Scaffold(
                              body: const Center(
                                child: const CircularProgressIndicator(),
                              ),
                            )
                          : AuthTabsScreen(),
                ),
          initialRoute: "/",
          routes: {
            // AppTabsScreen.routeName: (ctx) => AppTabsScreen(),
          },
        ),
      ),
    );
  }
}
