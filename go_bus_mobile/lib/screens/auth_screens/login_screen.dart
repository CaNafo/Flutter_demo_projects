import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../../providers/auth_provider.dart';
import '../../widgets/password_input_field.dart';
import '../../providers/locale_provider.dart';
import '../../widgets/change_language.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _loginForm;
  var email = "";
  var password = "";

  @override
  void initState() {
    _loginForm = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    final _localeProvider = Provider.of<LocaleProvider>(context);

    _saveForm() async {
      bool validated = _loginForm.currentState.validate();
      if (!validated) return;

      _loginForm.currentState.save();

      try {
        await _authProvider.login(email, password, null);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } catch (e) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
            key: _loginForm,
            child: Container(
              width: double.infinity,
              height: 500,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).email_placeholder,
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (email) =>
                        _authProvider.validateEmailField(email, context),
                    onSaved: (value) => email = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordInputField(
                    validate: (password) =>
                        _authProvider.validateLoginPassword(password, context),
                    placeholder:
                        AppLocalizations.of(context).password_placeholder,
                    onChanged: (text) => password = text,
                    textInputAction: TextInputAction.send,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).login_button,
                      ),
                      const SizedBox(
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
                  ChangeLanguage(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
