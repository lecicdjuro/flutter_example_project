import 'package:flutter_example_app/networking/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getLanguageCodes() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('CODE');
}

Future<void> setSupportedLanguages(List<Language> languageCodes) async {}
