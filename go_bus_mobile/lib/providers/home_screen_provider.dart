import 'package:flutter/cupertino.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenProvider with ChangeNotifier {
  Future<void> addQuestion(
    String question,
    List technologiesList,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    var userID = extractedUserData['userId'];
    final url = Uri.parse(
        'https://flutter-praksa-default-rtdb.firebaseio.com/Questions/$userID.json');

    try {
      // await http.put(
      //   url,
      //   body: json.encode(
      //     question,
      //   ),
      // );
      await http.post(
        url,
        body: json.encode({
          "question": question,
          "tech": technologiesList.toString(),
        }),
      );
    } catch (error) {
      throw error;
    }
  }
}
