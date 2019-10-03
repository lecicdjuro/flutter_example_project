import 'dart:convert';

import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/networking/networking.dart' as net;
import 'package:http/http.dart' as http;

Future<List<Language>> getSupportedLanguages() async {
  String url = net.baseUrl + '/languages?key=${net.apiKey}';

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return parseResponse(response.body);
  } else {
    throw Exception('Failed to fetch supported languages');
  }
}

List<Language> parseResponse(dynamic response) {
  final dynamic responseString = json.decode(response);
  final dynamic dataJSON = responseString['data'];

  final List<dynamic> translationsJSON = dataJSON['languages'];
  return translationsJSON
      .map((dynamic translation) => Language.fromJson(translation))
      .toList();
}
