import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/resources/dimens.dart' as dimens;

class TranslationItemWidget extends StatelessWidget {
  TranslationItemWidget(this.translation, {this.onFavoritePressed});

  final Translation translation;
  final VoidCallback onFavoritePressed;

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
                      Text(translation?.textToTranslate ?? ''),
                      Text(
                        translation?.translatedText ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
