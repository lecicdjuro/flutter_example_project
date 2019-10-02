import 'dart:convert';

import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:http/http.dart' as http;

Future<Translation> translationRequest(
    String text, String targetLanguage) async {
  String apiKey = 'AIzaSyAqnBxr-G5811raZcYmWODowYofAnd6TjU';
  String url =
      'https://translation.googleapis.com/language/translate/v2?target=$targetLanguage&key=$apiKey&q=$text';

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return parseResponse(response.body);
  } else {
    throw Exception('Failed to translate text');
  }
}

Translation parseResponse(dynamic response) {
  final dynamic responseString = json.decode(response);
  final dynamic dataJSON = responseString['data'];

  final List<dynamic> translationsJSON = dataJSON['translations'];
  return translationsJSON
      .map((dynamic translation) => Translation.fromJson(translation))
      .toList()
      .elementAt(0);
}