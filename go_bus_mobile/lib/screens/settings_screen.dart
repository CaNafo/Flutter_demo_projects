import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/info_dialog.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<FormState> formKey;

  String _validateUsernameField(String username) {
    if (username != null && username.length > 0) return null;
    return "Molimo vas da unesete korisničko ime";
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
          const Text(
            "Podešavanja",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          const Image(
            image: const AssetImage("assets/images/user_avatar.png"),
            height: 150,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Korisničko ime',
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
                                  title: "Čestitamo",
                                  descriptions:
                                      "Uspješno ste promijenili vaše korisničko ime.",
                                  text: "OK",
                                );
                              });
                        },
                      );
                    },
                    child: Text("Sačuvaj"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).buttonColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: TextButton(
              onPressed: () {
                _authProvider.logout();
              },
              child: const Text(
                "Odjavi se",
                style: TextStyle(
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
