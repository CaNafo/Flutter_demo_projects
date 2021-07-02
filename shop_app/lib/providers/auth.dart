import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expairyDate;
  String _userID;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expairyDate != null &&
        _expairyDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userID;
  }

  static const _API_KEY = 'AIzaSyCtEr4DNg8yVj3zN48OxkehR_QVxH9Q8Zg';

  Future<void> _authenticate(
      String email, String password, String urlParam) async {
    final url = Uri.parse('$urlParam');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      var responseBody = json.decode(response.body);

      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }
      _token = responseBody['idToken'];
      _userID = responseBody['localId'];
      _expairyDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_API_KEY');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_API_KEY');
  }
}
