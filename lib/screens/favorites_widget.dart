import 'package:flutter/material.dart';
import 'package:flutter_example_app/database/transaltion_dao.dart';
import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:flutter_example_app/screens/translation_card_item.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  List<Translation> favorites = [];
  TranslationDao _translationDao = TranslationDao();

  @override
  void initState() {
    _translationDao.getAllTranslations().then((List<Translation> translations) {
      setState(() {
        favorites = translations;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (BuildContext context, int index) {
        Translation translation = favorites.elementAt(index);
        return TranslationItemWidget(
          translation,
          onFavoritePressed: () {
            _translationDao.delete(translation);
            favorites.remove(translation);
            setState(() {});
          },
        );
      },
    );
  }
}
