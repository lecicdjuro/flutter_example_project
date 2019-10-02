import 'package:flutter_example_app/networking/models/language.dart';

class DetectedLanguage extends Language {
  final double confidence;
  final bool isReliable;

  DetectedLanguage(this.confidence, this.isReliable, String code)
      : super(code: code);

  factory DetectedLanguage.fromJson(Map<String, dynamic> translationJSON) {
    return DetectedLanguage(translationJSON['confidence'].toDouble(),
        translationJSON['isReliable'], translationJSON['language']);
  }
}
