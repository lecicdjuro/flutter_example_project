class Language {
  final String code;
  final String name;

  Language({this.code, this.name});

  factory Language.fromJson(Map<String, dynamic> translationJSON) {
    return Language(
        code: translationJSON['language'], name: translationJSON['name']);
  }

  String getName() {
    return name ?? code;
  }
}
