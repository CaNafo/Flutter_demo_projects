import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userID;
  Timer _authTimer;

  static const _API_KEY = 'AIzaSyDf4yapBLk3EYDD3tfpdUacBMj_-JWFNwk';

  // Methods for verifying login and register input fields
  String validateEmailField(String email) {
    if (email != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) return null;

    return "Molimo vas da provjerite e-mail adresu";
  }

  String validateRegisterPasswordField(String password) {
    if (password == null || password.length < 1)
      return "Molimo vas da unesete lozinku";

    if (password.length < 7)
      return "Lozinka mora sadržati najmanje 7 karaktera";

    if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{7,}$").hasMatch(password))
      return "Lozinka mora sadržati najmanje jedno slovo i jedan broj";

    return null;
  }

  String validateRepeatPasswordField(String repeatedPassword, password) {
    if (repeatedPassword == null || repeatedPassword.length < 1)
      return "Molimo vas da unesete lozinku";

    if (repeatedPassword != password) return "Lozinke se ne podudaraju";

    return null;
  }

  String validateLoginPassword(String password) {
    if (password == null || password.length < 1)
      return "Molimo Vas da unesete lozinku";
    return null;
  }

  String validateUsername(String username) {
    if (username == null || username.length < 1)
      return "Molimo Vas da unesete korisničko ime";
    return null;
  }

  //Methods for authentication user (Register and login)
  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) return _token;

    return null;
  }

  Future<void> _authenticate(
      String email, String password, String username, String urlParam) async {
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
        if (responseBody['error']['message'] == "EMAIL_EXISTS")
          throw HttpException("Email se već koristi.");
        if (responseBody['error']['message'] == "INVALID_PASSWORD")
          throw HttpException("Pogrešna lozinka.");
        else
          throw HttpException(responseBody['error']['message']);
      }
      _token = responseBody['idToken'];
      _userID = responseBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody['expiresIn']),
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userID,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);

      if (username != null) await writeUsernameToDb(username, _userID);

      _autoLogout();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signUp(String email, String password, String username) async {
    return _authenticate(email, password, username,
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_API_KEY');
  }

  Future<void> login(String email, String password, String username) async {
    return _authenticate(email, password, username,
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_API_KEY');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userID = extractedUserData['userId'];
    _expiryDate = expiryDate;
    _autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> writeUsernameToDb(String username, userID) async {
    final url = Uri.parse(
        'https://flutter-praksa-default-rtdb.firebaseio.com/Users/$userID.json');

    try {
      var res = await http.put(
        url,
        body: json.encode(
          {
            "username": username,
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userID = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
