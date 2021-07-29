import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QAProvider with ChangeNotifier {
  Future<List> fetchQuestions() async {
    List questions = [];

    final url = Uri.parse(
        'https://flutter-praksa-default-rtdb.firebaseio.com/Questions.json');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return [];
      }

      Future<String> fetchUsername(String key) async {
        final usersUrl = Uri.parse(
            'https://flutter-praksa-default-rtdb.firebaseio.com/Users/$key.json');
        final userResponse = await http.get(usersUrl);
        final extractedData = json.decode(userResponse.body);
        return (extractedData['username']);
      }

      for (var i = 0; i < extractedData.keys.length; i++) {
        var tempQuestionData = extractedData[extractedData.keys.elementAt(i)]
            as Map<String, dynamic>;
        var username = await fetchUsername(extractedData.keys.elementAt(i));
        for (var j = 0; j < tempQuestionData.keys.length; j++) {
          var questionData = {
            "userId": extractedData.keys.elementAt(i),
            "username": username,
            "question": tempQuestionData[tempQuestionData.keys.elementAt(j)]
                ['question'],
            "answer": tempQuestionData[tempQuestionData.keys.elementAt(j)]
                ['answer'],
            "technologies": tempQuestionData[tempQuestionData.keys.elementAt(j)]
                ['tech']
          };
          questions.add(questionData);
        }
      }
      return questions;
    } catch (e) {
      return [];
    }
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return "";
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    return extractedUserData['userId'];
  }
}
