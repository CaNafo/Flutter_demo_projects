import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingsProvider with ChangeNotifier {
  Future<bool> changeUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final userId = extractedUserData['userId'];

    try {
      final usersUrl = Uri.parse(
          'https://flutter-praksa-default-rtdb.firebaseio.com/Users/$userId.json');
      var res = await http.put(
        usersUrl,
        body: json.encode(
          {
            "username": username,
          },
        ),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
