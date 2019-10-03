import 'package:flutter/material.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/networking/requests/translation_request.dart';

class TranslatorScreen extends StatefulWidget {
  TranslatorScreen(this.supportedLanguages);

  final List<Language> supportedLanguages;

  @override
  TranslatorScreenState createState() =>
      TranslatorScreenState(supportedLanguages);
}

class TranslatorScreenState extends State<TranslatorScreen> {
  TranslatorScreenState(this.supportedLanguages);

  int tabIndex = 0;
  final List<Language> supportedLanguages;
  Translation translation;
  Language languageTo;
  Language languageFrom;
  TextEditingController editingController = TextEditingController();
  List<DropdownMenuItem<Language>> translationDropdownWidgets;

  @override
  void initState() {
    languageTo = supportedLanguages.elementAt(0);
    translationDropdownWidgets = supportedLanguages.map((Language language) {
      return DropdownMenuItem<Language>(
        child: Text(language.name),
        value: language,
      );
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Card(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        buildDropDownRow(),
                        TextField(
                          onChanged: translate,
                          controller: editingController,
                        )
                      ],
                    ))),
            Padding(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              child: Text('Translations'),
            ),
            Card(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(editingController.text ?? ''),
                              Text(
                                translation?.translatedText ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.favorite),
                      ],
                    ))),
          ],
        ));
  }

  Row buildDropDownRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: DropdownButton<Language>(
            hint: Text('Detect'),
            value: languageFrom,
            isExpanded: true,
            underline: Container(
              height: 1,
              color: Colors.grey,
            ),
            onChanged: (Language newValue) {
              languageFrom = newValue;
              translate(editingController.text);
            },
            items: translationDropdownWidgets,
          ),
        ),
        Expanded(
          flex: 1,
          child: Icon(Icons.repeat),
        ),
        Expanded(
          flex: 2,
          child: DropdownButton(
            value: languageTo,
            underline: Container(
              height: 1,
              color: Colors.grey,
            ),
            onChanged: (Language newValue) {
              languageTo = newValue;
              translate(editingController.text);
            },
            items: translationDropdownWidgets,
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Future<void> translate(String text) async {
    translation = await translationRequest(text, 'es');
    setState(() {});
  }
}
