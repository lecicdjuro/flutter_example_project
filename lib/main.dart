import 'package:flutter/material.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/screens/home_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'internationalization/languages.dart' as language;
import 'internationalization/localizations_delegate.dart';
import 'networking/requests/supported_languages_request.dart';

final Iterable<Locale> supportedLocales = <Locale>[
  const Locale(language.english, ''),
  const Locale(language.polish, ''),
];
final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
  const AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

void main() {
  getSupportedLanguages().then((List<Language> languages) {
    runApp(SupernovaApp(languages));
  }).catchError((error) {
    print(error);
  });
}

class SupernovaApp extends StatelessWidget {
  const SupernovaApp(this.supportedLanguages);

  final List<Language> supportedLanguages;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(supportedLanguages),
    );
  }
}
