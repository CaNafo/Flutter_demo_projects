import 'package:flutter/material.dart';

import './login_screen.dart';
import './register_screen.dart';

class AuthTabsScreen extends StatefulWidget {
  @override
  _AuthTabsScreenState createState() => _AuthTabsScreenState();
}

class _AuthTabsScreenState extends State<AuthTabsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var tabIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.previousIndex == 1)
      setState(() {
        tabIndex = 1;
      });
    else
      setState(() {
        tabIndex = 0;
      });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Image(
        image: AssetImage("assets/images/demo_app_logo.png"),
        height: 50,
      ),
      bottom: TabBar(
        indicatorColor: Theme.of(context).buttonColor,
        tabs: [
          const Tab(
            icon: null,
            text: "Prijavi se",
          ),
          const Tab(
            icon: null,
            text: "Registruj se",
          ),
        ],
        controller: _tabController,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
    );

    final mediaQuery = MediaQuery.of(context);
    final heigth = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        0.9;

    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            height: heigth,
            child: TabBarView(
              controller: _tabController,
              children: [
                LoginScreen(),
                RegisterScreen(),
              ],
            ),
          ),
          if (tabIndex == 1)
            TextButton(
              onPressed: () {
                _tabController.animateTo(tabIndex);
              },
              child: const Text("Nemate nalog? Registrujte se ovdje."),
            ),
        ]),
      ),
    );
  }
}
