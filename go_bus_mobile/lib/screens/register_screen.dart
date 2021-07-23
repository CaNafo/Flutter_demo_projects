import 'package:flutter/material.dart';

import '../widgets/password_input_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final _registerForm = GlobalKey<FormState>();
    var password = "";

    String _validateEmailField(String email) {
      if (email != null &&
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email)) return null;

      return "Molimo vas da provjerite e-mail adresu";
    }

    String _validatePasswordField(String password) {
      if (password == null || password.length < 1)
        return "Molimo vas da unesete lozinku";

      if (password.length < 7)
        return "Lozinka mora sadržati najmanje 7 karaktera";

      if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{7,}$").hasMatch(password))
        return "Lozinka mora sadržati najmanje jedno slovo i jedan broj";

      return null;
    }

    String _validateRepeatPasswordField(String repeatedPassword) {
      if (repeatedPassword == null || repeatedPassword.length < 1)
        return "Molimo vas da unesete lozinku";

      if (repeatedPassword != password) return "Lozinke se ne podudaraju";

      return null;
    }

    void _saveForm() {
      _registerForm.currentState.validate();
    }

    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Zdravo,",
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
            Text(
              "Dobrodošli!",
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
            Form(
              key: _registerForm,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'email@domen.com',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: _validateEmailField,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PasswordInputField(
                      validate: _validatePasswordField,
                      placeholder: "Lozinka",
                      onChanged: (pass) => password = pass,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PasswordInputField(
                      validate: _validateRepeatPasswordField,
                      placeholder: "Lozinka",
                      onChanged: (pass) => {},
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Registruj se'),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: _saveForm,
                          child: const Icon(
                            Icons.arrow_right_alt_sharp,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).buttonColor,
                            ),
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
