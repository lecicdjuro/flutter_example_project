import 'package:flutter/material.dart';
import 'package:flutter_example_app/internationalization/localizations.dart';
import 'package:flutter_example_app/networking/models/language.dart';
import 'package:flutter_example_app/screens/favorites_widget.dart';
import 'package:flutter_example_app/screens/translator_widget.dart';

class Home extends StatefulWidget {
  Home(this.supportedLanguages);

  final List<Language> supportedLanguages;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationResources.of(buildContext).title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabPressed,
        currentIndex: tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.translate),
            title: new Text(LocalizationResources.of(context).translate),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text(LocalizationResources.of(context).favorite),
          )
        ],
      ),
      body: tabIndex == 0
          ? TranslatorScreen(widget.supportedLanguages)
          : FavoritesScreen(),
    );
  }

  void onTabPressed(int index) {
    setState(() {
      tabIndex = index;
    });
  }
}
