import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_example_app/internationalization/localizations.dart';
import 'package:flutter_example_app/internationalization/languages.dart'
    as language;

class AppLocalizationsDelegate
    extends LocalizationsDelegate<LocalizationResources> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => <String>[
        language.english,
        language.polish
      ].contains(locale.languageCode);

  @override
  Future<LocalizationResources> load(Locale locale) {
    return LocalizationResources.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
