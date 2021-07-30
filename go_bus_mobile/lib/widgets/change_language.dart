import 'package:flutter/material.dart';

import './language_button.dart';

class ChangeLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LanguageButton(
          flagImage: const AssetImage("assets/images/bih_flag.png"),
          locale: "sr",
        ),
        SizedBox(
          width: 5,
        ),
        const LanguageButton(
          flagImage: const AssetImage("assets/images/en_flag.png"),
          locale: "en",
        ),
      ],
    );
  }
}
