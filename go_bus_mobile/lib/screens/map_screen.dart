import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  static const routeName = "/home-screen";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text("Map screen"),
      ),
    );
  }
}
