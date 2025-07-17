import 'package:hive_flutter/hive_flutter.dart';
import '../../models/local/event_model.dart';
import '../../models/local/packing_model.dart';
import '../../models/local/language_model.dart';
import '../../models/local/phrases_model.dart';
import '../../models/local/traveler_model.dart';

class HiveDataSource {

  /// Init Hive Local Storage
  static Future<void> init() async {
    await Hive.initFlutter();

    /// Define the adapters
    Hive.registerAdapter(EventAdapter());
    Hive.registerAdapter(TravelerAdapter());
    Hive.registerAdapter(PackingAdapter());
    Hive.registerAdapter(LanguageModelAdapter());
    Hive.registerAdapter(PhrasesModelAdapter());

    /// Open the boxes
    await Hive.openBox<Event>('eventBox');
    await Hive.openBox<Traveler>('travelerBox');
    await Hive.openBox<Packing>('packingBox');
    await Hive.openBox<LanguageModel>('languageBox');
    await Hive.openBox<PhrasesModel>('phrasesBox');
    await Hive.openBox('settingBox');
  }

  /// Get the boxes
  Box<Event> get eventBox => Hive.box<Event>('eventBox');
  Box<Traveler> get travelerBox => Hive.box<Traveler>('travelerBox');
  Box<Packing> get packingBox => Hive.box<Packing>('packingBox');
  Box<LanguageModel> get languageBox => Hive.box<LanguageModel>('languageBox');
  Box<PhrasesModel> get phrasesBox => Hive.box<PhrasesModel>('phrasesBox');
  Box get settingBox => Hive.box('settingBox');

}