import 'package:flutter/material.dart';
import 'package:flutter_example_app/database/transaltion_dao.dart';
import 'package:flutter_example_app/internationalization/localizations.dart';
import 'package:flutter_example_app/networking/models/detected_langugage.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/networking/requests/detect_language_request.dart';
import 'package:flutter_example_app/networking/requests/translation_request.dart';
import 'package:flutter_example_app/resources/dimens.dart' as dimens;

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
  Language detectedLanguage;
  TranslationDao _translationDao = TranslationDao();

  TextEditingController editingController = TextEditingController();
  List<DropdownMenuItem<Language>> translationDropdownWidgets;

  @override
  void initState() {
    if (languageTo == null) {
      languageTo = supportedLanguages.elementAt(0);
    }
    translationDropdownWidgets = supportedLanguages.map((Language language) {
      return DropdownMenuItem<Language>(
        child: Text(language?.name),
        value: language,
      );
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(dimens.smallPadding),
        child: Column(
          children: <Widget>[
            Card(
                child: Padding(
                    padding: EdgeInsets.all(dimens.largePadding),
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
              padding: EdgeInsets.only(
                  top: dimens.smallPadding, bottom: dimens.smallPadding),
              child: Text(LocalizationResources.of(context).translations),
            ),
            Card(
                child: Padding(
                    padding: EdgeInsets.all(dimens.largePadding),
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
          flex: dimens.bigFlexSize,
          child: _buildDropdownButton(
              LocalizationResources.of(context).detect, true),
        ),
        Expanded(
          flex: dimens.defaultFlexSize,
          child: Icon(Icons.repeat),
        ),
        Expanded(
            flex: dimens.bigFlexSize, child: _buildDropdownButton('', false)),
      ],
    );
  }

  DropdownButton<Language> _buildDropdownButton(
      String hintMessage, bool isLanguageFrom) {
    return DropdownButton<Language>(
      hint: Text(hintMessage),
      value: supportedLanguages.singleWhere(
          (Language language) =>
              language.code ==
              (isLanguageFrom ? languageFrom?.code : languageTo?.code),
          orElse: () => null),
      isExpanded: true,
      underline: Container(
        height: dimens.underlineHeight,
        color: Colors.grey,
      ),
      onChanged: (Language newValue) {
        isLanguageFrom ? languageFrom = newValue : languageTo = newValue;
        String text = editingController.text;
        translate(text);
      },
      items: translationDropdownWidgets,
    );
  }

  Future<void> translate(String text) async {
    if (text.isNotEmpty) {
      if (languageFrom != null) {
        translation =
            await translationRequest(text, languageFrom.code, languageTo.code);
        languageFrom = Language(code: translation.sourceLanguage);
        translation.targetLanguage = languageTo.code;
        _translationDao.insert(translation);
      }
      DetectedLanguage detectedLanguage = await detectLanguage(text);
      if (languageFrom == null || detectedLanguage.confidence < 0.91) {
        languageFrom = detectedLanguage;
      }
    }
    setState(() {});
  }
}
