import 'package:flutter_example_app/internationalization/languages.dart';

String getLanguageName(String code) {
  var result;
  languages.forEach((key, value) {
    if (key == code) result = value;
  });
  if (result != null) return result;
  return 'detect';
}

class Language {
  final String code;
  String name;

  Language({this.code, this.name});

  factory Language.fromJson(Map<String, dynamic> translationJSON) {
    return Language(
        code: translationJSON['language'],
        name: translationJSON['name'] ??
            getLanguageName(translationJSON['language']));
  }
}
