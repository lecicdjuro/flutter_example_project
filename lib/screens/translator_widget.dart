import 'package:flutter/material.dart';
import 'package:flutter_example_app/database/transaltion_dao.dart';
import 'package:flutter_example_app/internationalization/localizations.dart';
import 'package:flutter_example_app/networking/models/detected_langugage.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/networking/requests/detect_language_request.dart';
import 'package:flutter_example_app/networking/requests/translation_request.dart';
import 'package:flutter_example_app/resources/dimens.dart' as dimens;
import 'package:flutter_example_app/resources/colors.dart' as colors;
import 'package:flutter_example_app/resources/styles.dart';
import 'package:flutter_example_app/screens/translation_card_item.dart';

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
  DetectedLanguage detectedLanguage;
  TranslationDao _translationDao = TranslationDao();

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    if (languageTo == null) {
      languageTo = supportedLanguages.elementAt(0);
    }
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
                          onChanged: performTranslation,
                          controller: editingController,
                        )
                      ],
                    ))),
            Padding(
              padding: EdgeInsets.only(
                  top: dimens.smallPadding, bottom: dimens.smallPadding),
              child: Text(
                LocalizationResources.of(context).translations,
                style: OpenSansStyle(
                    color: colors.tertiaryText, fontSize: dimens.normalText),
              ),
            ),
            TranslationItemWidget(
              translation,
              isAutoDetect: detectedLanguage != null,
              onFavoritePressed: () {
                setState(() {
                  translation.isFavorite = !translation.isFavorite;
                  if (translation.isFavorite) {
                    _translationDao.insert(translation);
                  } else {
                    _translationDao.delete(translation);
                  }
                });
              },
            ),
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
          child: GestureDetector(
            onTap: reverseItems,
            child: Icon(Icons.swap_horiz),
          ),
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
        if (isLanguageFrom) {
          languageFrom = newValue;
          detectedLanguage = null;
        } else {
          languageTo = newValue;
        }
        performTranslation(editingController.text);
      },
      items: supportedLanguages.map((Language language) {
        return DropdownMenuItem<Language>(
          child: Text(language?.name),
          value: language,
        );
      }).toList(),
    );
  }

  Future<void> translate(String text, {String languageCodeFrom}) async {
    if (text.isNotEmpty) {
      translation =
          await translationRequest(text, languageCodeFrom, languageTo.code);

      await checkForFavorite();
    }
    setState(() {});
  }

  Future<void> detect(String text) async {
    if (detectedLanguage == null || detectedLanguage.confidence < 1) {
      detectedLanguage = await detectLanguage(text);
    }
    translate(text, languageCodeFrom: detectedLanguage.code);
  }

  Future checkForFavorite() async {
    List<Translation> trans =
        await _translationDao.getTranslationByText(translation);
    for (Translation favorite in trans) {
      if (favorite.translatedText == translation.translatedText &&
          favorite.textToTranslate == translation.textToTranslate) {
        translation = favorite;
        break;
      }
    }
  }

  Future<void> performTranslation(String value) async {
    if (languageFrom == null) {
      await detect(value);
    } else {
      await translate(value, languageCodeFrom: languageFrom.code);
    }
  }

  void reverseItems() {
    Language temp = languageFrom ?? detectedLanguage;
    languageFrom = languageTo;
    languageTo = temp;
    performTranslation(editingController.text);
  }
}
