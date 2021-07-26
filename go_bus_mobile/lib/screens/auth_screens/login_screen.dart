import 'package:flutter/material.dart';
import 'package:go_bus_mobile/screens/app_tabs_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/password_input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _loginForm;
  @override
  void initState() {
    _loginForm = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);

    _saveForm() {
      bool validated = _loginForm.currentState.validate();
      if (!validated) return;

      Navigator.of(context).pushReplacementNamed(AppTabsScreen.routeName);
    }

    return SingleChildScrollView(
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
            key: _loginForm,
            child: Container(
              width: double.infinity,
              height: 300,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: _authProvider.validateEmailField,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PasswordInputField(
                    validate: _authProvider.validateLoginPassword,
                    placeholder: "Lozinka",
                    onChanged: (text) {},
                    textInputAction: TextInputAction.send,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Uloguj se'),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
