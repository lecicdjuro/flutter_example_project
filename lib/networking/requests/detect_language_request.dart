import 'dart:convert';

import 'package:flutter_example_app/networking/models/detected_langugage.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/networking/networking.dart' as net;
import 'package:http/http.dart' as http;

Future<DetectedLanguage> detectLanguage(String text) async {
  String url = net.baseUrl + '/detect?q=$text&key=${net.apiKey}';
  final response = await http.post(url);

  if (response.statusCode == 200) {
    return parseResponse(response.body);
  } else {
    throw Exception('Failed to detect  langugage');
  }
}

Language parseResponse(dynamic response) {
  final dynamic responseString = json.decode(response);
  final dynamic dataJSON = responseString['data'];

  final List<dynamic> detectionsJson = dataJSON['detections'];

  return detectionsJson
      .elementAt(0)
      .map((dynamic detection) {
        return DetectedLanguage.fromJson(detection);
      })
      .toList()
      .elementAt(0);
}
