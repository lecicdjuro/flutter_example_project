class Translation {
  final String detectedSourceLanguage;
  final String translatedText;

  Translation({this.detectedSourceLanguage, this.translatedText});

  factory Translation.fromJson(Map<String, dynamic> translationJSON) {
    return Translation(
        translatedText: translationJSON['translatedText'],
        detectedSourceLanguage: translationJSON['detectedSourceLanguage']);
  }
}
