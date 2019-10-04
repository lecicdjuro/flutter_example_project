const String sourceLanguageFiled = 'sourceLanguage';
const String targetLanguageFiled = 'targetLanguage';
const String translatedTextField = 'translatedText';
const String isFavoriteField = 'isFavorite';
const String textToTranslateField = 'textTotTranslate';

class Translation {
  int key;
  final String sourceLanguage;
  String textToTranslate;
  final String translatedText;
  String targetLanguage;
  bool isFavorite = false;

  Translation(
      {this.sourceLanguage,
      this.textToTranslate,
      this.translatedText,
      this.targetLanguage,
      this.isFavorite = false});

  factory Translation.fromJson(Map<String, dynamic> translationJSON,
      {String textToTranslate, String sourceLanguage, String targetLanguage}) {
    return Translation(
        translatedText: translationJSON['translatedText'],
        sourceLanguage:
            translationJSON['detectedSourceLanguage'] ?? sourceLanguage,
        isFavorite: translationJSON['isFavorite'] ?? false,
        textToTranslate: translationJSON['textTotTranslate'] ?? textToTranslate,
        targetLanguage: translationJSON['targetLanguage'] ?? targetLanguage);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        sourceLanguageFiled: sourceLanguage,
        translatedTextField: translatedText,
        targetLanguageFiled: targetLanguage,
        isFavoriteField: isFavorite,
        textToTranslateField: textToTranslate
      };
}
