import 'package:flutter_example_app/networking/models/language.dart';

class DetectedLanguage extends Language {
  final double confidence;
  final bool isReliable;

  DetectedLanguage(this.confidence, this.isReliable, String code, String name)
      : super(code: code, name: name);

  factory DetectedLanguage.fromJson(Map<String, dynamic> translationJSON) {
    return DetectedLanguage(
        translationJSON['confidence'].toDouble(),
        translationJSON['isReliable'],
        translationJSON['language'],
        translationJSON['name'] ??
        getLanguageName(translationJSON['language']));
  }

  bool isUndetermined() {
    return code == 'und';
  }
}
