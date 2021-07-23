import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
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
}
