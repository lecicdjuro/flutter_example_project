import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

///class containing localization logic and string getters
class LocalizationResources {
  static Future<LocalizationResources> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return LocalizationResources();
    }).catchError((dynamic error){
      print(error);
    });
  }

  static LocalizationResources of(BuildContext context) {
    return Localizations.of<LocalizationResources>(
        context, LocalizationResources);
  }

  String get title {
    return Intl.message('', name: 'title');
  }
}
