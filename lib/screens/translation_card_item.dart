import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/internationalization/localizations.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/resources/colors.dart' as colors;
import 'package:flutter_example_app/resources/dimens.dart' as dimens;
import 'package:flutter_example_app/resources/styles.dart';

class TranslationItemWidget extends StatelessWidget {
  TranslationItemWidget(this.translation,
      {this.isAutoDetect = false, this.onFavoritePressed});

  final Translation translation;
  final VoidCallback onFavoritePressed;
  final bool isAutoDetect;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      Text(
                        translation?.textToTranslate ?? '',
                        style: OpenSansStyle(
                            color: colors.primaryText,
                            fontSize: dimens.largeText),
                      ),
                      Text(
                        translation?.translatedText ?? '',
                        style: OpenSansStyle(
                            color: colors.primaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: dimens.largeText),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: dimens.mediumPadding),
                        child: Text(
                          isAutoDetect
                              ? '${LocalizationResources.of(context).detectedLanguage} ${translation.sourceLanguage}'
                              : '',
                          style: OpenSansStyle(
                              color: colors.tertiaryText,
                              fontSize: dimens.smallText),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                translation != null
                    ? GestureDetector(
                        onTap: onFavoritePressed,
                        child: translation.isFavorite
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                      )
                    : Container(),
              ],
            )));
  }
}
