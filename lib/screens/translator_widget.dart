import 'package:flutter/material.dart';
import 'package:flutter_example_app/networking/models/detected_langugage.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/networking/requests/detect_language_request.dart';
import 'package:flutter_example_app/networking/requests/supported_languages_request.dart';
import 'package:flutter_example_app/networking/requests/translation_request.dart';

class SupernovaTranslatorScreen extends StatefulWidget {
  @override
  TranslatorScreenState createState() => TranslatorScreenState();
}

class TranslatorScreenState extends State<SupernovaTranslatorScreen> {
  int tabIndex = 0;
  List<Language> supportedLanguages;
  Translation translation;
  Language selectedLanguage;
  DetectedLanguage detectedLanguage;

  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
//    getSupportedLanguages().then((List<Language> languages) {
//      setState(() {
//        supportedLanguages = languages;
//      });
//    }).catchError((error) {
//      print(error);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(detectedLanguage != null ? detectedLanguage.getName() : ''),
          DropdownButton<Language>(
            value: supportedLanguages?.singleWhere(
                (Language language) => language.code == 'en',
                orElse: () => null),
            items: supportedLanguages?.map((Language language) {
              return DropdownMenuItem<Language>(
                value: language,
                child: Text(language?.name,
                    style: TextStyle(
                        color: Colors.black12,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              );
            })?.toList(),
            isExpanded: true,
            hint: Text(
              'Choose language',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            onChanged: (Language language) {
              setState(() {
                selectedLanguage = language;
              });
            },
          ),
          TextField(
            controller: textController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter a search term'),
            onChanged: (String text) {
              if (text == null || text == '') {
                detectedLanguage = null;
              } else {
                detectLanguage(text).then((DetectedLanguage language) {
                  setState(() {
                    detectedLanguage = language;
                  });
                });
              }
            },
          ),
          Text(
            translation?.detectedSourceLanguage ?? '',
          ),
          Text(
            '${translation?.translatedText ?? ''}',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }

  Future<void> translateText() async {
    translation = await translationRequest(textController.text, 'es');
    setState(() {});
  }
}
