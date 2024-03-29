import 'package:flutter_example_app/networking/models/translation.dart';
import 'package:sembast/sembast.dart';

import 'translator_database.dart';

class TranslationDao {
  static const String TRANSLATIONS_STORE_NAME = 'translations';
  final _translationStore = intMapStoreFactory.store(TRANSLATIONS_STORE_NAME);

  Future<Database> get _db async => await TranslatorDatabase.instance.database;

  Future insert(Translation translation) async {
    await _translationStore.add(await _db, translation.toJson());
  }

  Future update(Translation translation) async {
    final finder = Finder(filter: Filter.byKey(translation.key));
    await _translationStore.update(
      await _db,
      translation.toJson(),
      finder: finder,
    );
  }

  Future delete(Translation translation) async {
    final finder = Finder(filter: Filter.byKey(translation.key));
    await _translationStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Translation>> getAllTranslations() async {
    final finder = Finder(sortOrders: []);

    final recordSnapshots = await _translationStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final translation = Translation.fromJson(snapshot.value);
      translation.key = snapshot.key;
      return translation;
    }).toList();
  }

  Future<List<Translation>> getTranslationByText(
      Translation translation) async {
    var finder = Finder(
      filter: Filter.equals('translatedText', translation.translatedText),
    );
    final recordSnapshots = await _translationStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final translation = Translation.fromJson(snapshot.value);
      translation.key = snapshot.key;
      return translation;
    }).toList();
  }
}
