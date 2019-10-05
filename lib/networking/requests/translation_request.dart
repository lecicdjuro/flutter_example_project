import 'dart:convert';

import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_example_app/networking/networking.dart' as net;

Future<Translation> translationRequest(
    String text, String sourceLanguage, String targetLanguage) async {
  String url = buildUrl(net.baseUrl, text, sourceLanguage, targetLanguage);
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

String buildUrl(
    String url, String text, String sourceLanguage, String targetLanguage) {
  url += '?';
  if (sourceLanguage.isNotEmpty && targetLanguage.isNotEmpty) {
    url += 'source=$sourceLanguage';
    url += '&';
    url += 'target=$targetLanguage';
  } else {
    url += 'target=$targetLanguage';
  }
  url += '&';
  url += 'key=${net.apiKey}';
  url += '&';
  url += 'q=$text';

  return url;
}
