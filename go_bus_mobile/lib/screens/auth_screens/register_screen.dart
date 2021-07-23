import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/password_input_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _registerForm;

  @override
  void initState() {
    _registerForm = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var password = "";
    final _authProvider = Provider.of<AuthProvider>(context);

    void _saveForm() {
      _registerForm.currentState.validate();
    }

    return Column(
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
                  validator: _authProvider.validateEmailField,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Korisničko ime',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: _authProvider.validateUsername,
                ),
                const SizedBox(
                  height: 15,
                ),
                PasswordInputField(
                  validate: _authProvider.validateRegisterPasswordField,
                  placeholder: "Lozinka",
                  onChanged: (pass) => password = pass,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 15,
                ),
                PasswordInputField(
                  validate: (repeatedPass) => _authProvider
                      .validateRepeatPasswordField(repeatedPass, password),
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
    );
  }
}
