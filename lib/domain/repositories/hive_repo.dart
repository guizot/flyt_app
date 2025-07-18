import '../../data/models/local/document_model.dart';
import '../../data/models/local/packing_model.dart';
import '../../data/models/local/language_model.dart';
import '../../data/models/local/phrases_model.dart';
import '../../data/models/local/traveler_model.dart';
import '../../data/models/local/trip_model.dart';

abstract class HiveRepo {

  // region TRIP

  List<TripModel> getAllTrip();
  TripModel? getTrip(String id);
  Future<void> saveTrip(String id, TripModel item);
  Future<void> deleteTrip(String id);
  Future<void> deleteAllTrip(Iterable<dynamic> keys);

  // endregion

  // region TRAVELER

    List<Traveler> getAllTraveler();
    Traveler? getTraveler(String id);
    Future<void> saveTraveler(String id, Traveler item);
    Future<void> deleteTraveler(String id);
    Future<void> deleteAllTraveler(Iterable<dynamic> keys);

  // endregion

  // region DOCUMENT

  List<DocumentModel> getAllDocument();
  DocumentModel? getDocument(String id);
  Future<void> saveDocument(String id, DocumentModel item);
  Future<void> deleteDocument(String id);
  Future<void> deleteAllDocument(Iterable<dynamic> keys);

  // endregion

  // region PACKING

  List<Packing> getAllPacking();
  Packing? getPacking(String id);
  Future<void> savePacking(String id, Packing item);
  Future<void> deletePacking(String id);
  Future<void> deleteAllPacking(Iterable<dynamic> keys);

  // endregion

  // region LANGUAGE

  List<LanguageModel> getAllLanguage();
  LanguageModel? getLanguage(String id);
  Future<void> saveLanguage(String id, LanguageModel item);
  Future<void> deleteLanguage(String id);
  Future<void> deleteAllLanguage(Iterable<dynamic> keys);

  // endregion

  // region Phrases

  List<PhrasesModel> getAllPhrases();
  PhrasesModel? getPhrases(String id);
  Future<void> savePhrases(String id, PhrasesModel item);
  Future<void> deletePhrases(String id);
  Future<void> deleteAllPhrases(Iterable<dynamic> keys);

  // endregion

  // region SETTING

  dynamic getSetting(String key);
  Future<void> saveSetting(String key, dynamic item);
  Future<void> deleteSetting(String key);

  // endregion

}