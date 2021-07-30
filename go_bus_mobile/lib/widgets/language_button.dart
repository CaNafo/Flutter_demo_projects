import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/locale_provider.dart';

class LanguageButton extends StatelessWidget {
  final String locale;
  final AssetImage flagImage;

  const LanguageButton({
    this.locale,
    this.flagImage,
  });

  @override
  Widget build(BuildContext context) {
    final _localeProvider = Provider.of<LocaleProvider>(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            _localeProvider.setLocale(
              Locale(locale),
            );
          },
          icon: Image(
            image: flagImage,
          ),
          iconSize: 50,
        ),
        if (_localeProvider.locale != null &&
            _localeProvider.locale.languageCode == this.locale)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Card(
              color: Colors.transparent,
              child: Icon(
                Icons.check,
                size: 45,
                color: Colors.green[300],
              ),
            ),
          ),
      ],
    );
  }
}
