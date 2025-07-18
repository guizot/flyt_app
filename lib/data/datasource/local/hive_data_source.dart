import 'package:hive_flutter/hive_flutter.dart';
import '../../models/local/document_model.dart';
import '../../models/local/trip_model.dart';
import '../../models/local/packing_model.dart';
import '../../models/local/language_model.dart';
import '../../models/local/phrases_model.dart';
import '../../models/local/traveler_model.dart';

class HiveDataSource {

  /// Init Hive Local Storage
  static Future<void> init() async {
    await Hive.initFlutter();

    /// Define the adapters
    Hive.registerAdapter(TripModelAdapter());
    Hive.registerAdapter(TravelerAdapter());
    Hive.registerAdapter(PackingAdapter());
    Hive.registerAdapter(LanguageModelAdapter());
    Hive.registerAdapter(PhrasesModelAdapter());
    Hive.registerAdapter(DocumentModelAdapter());

    /// Open the boxes
    await Hive.openBox<TripModel>('tripBox');
    await Hive.openBox<Traveler>('travelerBox');
    await Hive.openBox<Packing>('packingBox');
    await Hive.openBox<LanguageModel>('languageBox');
    await Hive.openBox<PhrasesModel>('phrasesBox');
    await Hive.openBox<DocumentModel>('documentBox');
    await Hive.openBox('settingBox');
  }

  /// Get the boxes
  Box<TripModel> get tripBox => Hive.box<TripModel>('tripBox');
  Box<Traveler> get travelerBox => Hive.box<Traveler>('travelerBox');
  Box<Packing> get packingBox => Hive.box<Packing>('packingBox');
  Box<LanguageModel> get languageBox => Hive.box<LanguageModel>('languageBox');
  Box<PhrasesModel> get phrasesBox => Hive.box<PhrasesModel>('phrasesBox');
  Box<DocumentModel> get documentBox => Hive.box<DocumentModel>('documentBox');
  Box get settingBox => Hive.box('settingBox');

}