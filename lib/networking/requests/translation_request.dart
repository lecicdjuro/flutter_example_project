import 'dart:convert';

import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_example_app/networking/networking.dart' as net;

Future<Translation> translationRequest(
    String text, String sourceLanguage, String targetLanguage) async {
  String apiKey = 'AIzaSyAqnBxr-G5811raZcYmWODowYofAnd6TjU';
  String url = net.baseUrl +
      '?source=$sourceLanguage&target=$targetLanguage&key=$apiKey&q=$text';
  print(url);
  final response = await http.post(url);

  if (response.statusCode == 200) {
    return parseResponse(text, sourceLanguage, targetLanguage, response.body);
  } else {
    throw Exception('Failed to translate text');
  }
}

Translation parseResponse(String textToTranslate, String sourceLanguage,
    String targetLanguage, dynamic response) {
  final dynamic responseString = json.decode(response);
  final dynamic dataJSON = responseString['data'];

  final List<dynamic> translationsJSON = dataJSON['translations'];
  return translationsJSON
      .map((dynamic translation) => Translation.fromJson(translation,
          textToTranslate: textToTranslate,
          sourceLanguage: sourceLanguage,
          targetLanguage: targetLanguage))
      .toList()
      .elementAt(0);
}
