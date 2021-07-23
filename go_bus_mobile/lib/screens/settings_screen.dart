import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/home-screen";
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email adresa',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Korisničko ime',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Lozinka',
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
          )),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
            child: const Text("Odjavi se"),
          ),
        ],
      ),
    );
  }
}
