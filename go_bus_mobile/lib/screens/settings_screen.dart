import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/info_dialog.dart';
import '../widgets/change_language.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class SettingsScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<FormState> formKey;

  String _validateUsernameField(String username) {
    if (username != null && username.length > 0) return null;
    return AppLocalizations.of(context).username_validation_empty;
  }

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var usernameController = TextEditingController();
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(context).settings_screeen_title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          const Image(
            image: const AssetImage("assets/images/user_avatar.png"),
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).username_placeholder,
                      ),
                      textInputAction: TextInputAction.send,
                      validator: _validateUsernameField,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState.validate()) return;
                      formKey.currentState.save();
                      showDialog(
                          context: context,
                          builder: (ctx) => const AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: const Center(
                                  child: const CircularProgressIndicator(),
                                ),
                              ));
                      Provider.of<SettingsProvider>(
                        context,
                        listen: false,
                      ).changeUsername(usernameController.text).then(
                        (value) {
                          if (value)
                            setState(() {
                              usernameController.text = "";
                            });
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return InfoDialog(
                                  title: AppLocalizations.of(context)
                                      .congrats_dialog_title,
                                  descriptions: AppLocalizations.of(context)
                                      .successfully_changed_username_dialog_text,
                                  text: "OK",
                                );
                              });
                        },
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context).save_btn,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).buttonColor),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ChangeLanguage(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: TextButton(
              onPressed: () {
                _authProvider.logout();
              },
              child: Text(
                AppLocalizations.of(context).sign_out_btn,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
