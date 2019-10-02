import 'package:flutter/material.dart';
import 'package:flutter_example_app/networking/requests/translation_request.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'internationalization/languages.dart' as language;
import 'internationalization/localizations.dart';
import 'internationalization/localizations_delegate.dart';
import 'networking/models/translation.dart';

final Iterable<Locale> supportedLocales = <Locale>[
  const Locale(language.english, ''),
  const Locale(language.polish, ''),
];
final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
  const AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Translation translation;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationResources.of(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter a search term'),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pingGoogle,
        child: Icon(Icons.send),
      ),
    );
  }

  Future<void> pingGoogle() async {
    translation = await translationRequest(textController.text, 'es');
    setState(() {});
  }
}
