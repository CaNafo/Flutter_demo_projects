import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../../widgets/password_input_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _registerForm;
  var _email = '';
  var _password = '';
  var _username = '';

  @override
  void initState() {
    _registerForm = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _saveForm() async {
      if (!_registerForm.currentState.validate()) return;
      _registerForm.currentState.save();
      try {
        await _authProvider.signUp(_email, _password, _username);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "$e",
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).auth_welcome_message_1,
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
          Text(
            AppLocalizations.of(context).auth_welcome_message_2,
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
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .email_example_placeholder,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (email) =>
                        _authProvider.validateEmailField(email, context),
                    onSaved: (inputText) => _email = inputText,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).username_placeholder,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (username) =>
                        _authProvider.validateUsername(username, context),
                    onSaved: (inputText) => _username = inputText,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordInputField(
                    validate: (password) => _authProvider
                        .validateRegisterPasswordField(password, context),
                    placeholder:
                        AppLocalizations.of(context).password_placeholder,
                    onChanged: (pass) => _password = pass,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordInputField(
                    validate: (repeatedPass) =>
                        _authProvider.validateRepeatPasswordField(
                            repeatedPass, _password, context),
                    placeholder:
                        AppLocalizations.of(context).password_placeholder,
                    onChanged: (pass) => {},
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).register_button,
                      ),
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
    );
  }
}
