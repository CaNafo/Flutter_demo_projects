import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expairyDate;
  String _userID;

  static const _API_KEY = 'AIzaSyDf4yapBLk3EYDD3tfpdUacBMj_-JWFNwk';

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
        if (responseBody['error']['message'] == "EMAIL_EXISTS")
          throw HttpException("Email se već koristi.");
        else
          throw HttpException("Došlo je do greške.");
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
