const String sourceLanguageFiled = 'sourceLanguage';
const String targetLanguageFiled = 'targetLanguage';
const String translatedTextField = 'translatedText';

class Translation {
  int key;
  final String sourceLanguage;
  final String translatedText;
  String targetLanguage;

  Translation({this.sourceLanguage, this.translatedText, this.targetLanguage});

  factory Translation.fromJson(Map<String, dynamic> translationJSON) {
    return Translation(
      translatedText: translationJSON['translatedText'],
      sourceLanguage: translationJSON['detectedSourceLanguage'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        sourceLanguageFiled: sourceLanguage,
        translatedTextField: translatedText,
        targetLanguageFiled: targetLanguage
      };
}
