import '../../data/models/local/booking_model.dart';
import '../../data/models/local/document_model.dart';
import '../../data/models/local/itinerary_model.dart';
import '../../data/models/local/location_model.dart';
import '../../data/models/local/note_model.dart';
import '../../data/models/local/packing_model.dart';
import '../../data/models/local/language_model.dart';
import '../../data/models/local/path_model.dart';
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

  // region PHRASES

  List<PhrasesModel> getAllPhrases();
  PhrasesModel? getPhrases(String id);
  Future<void> savePhrases(String id, PhrasesModel item);
  Future<void> deletePhrases(String id);
  Future<void> deleteAllPhrases(Iterable<dynamic> keys);

  // endregion

  // region BOOKING

  List<BookingModel> getAllBooking();
  BookingModel? getBooking(String id);
  Future<void> saveBooking(String id, BookingModel item);
  Future<void> deleteBooking(String id);
  Future<void> deleteAllBooking(Iterable<dynamic> keys);

  // endregion

  // region ITINERARY

  List<ItineraryModel> getAllItinerary();
  ItineraryModel? getItinerary(String id);
  Future<void> saveItinerary(String id, ItineraryModel item);
  Future<void> deleteItinerary(String id);
  Future<void> deleteAllItinerary(Iterable<dynamic> keys);

  // endregion

  // region LOCATION

  List<LocationModel> getAllLocation();
  LocationModel? getLocation(String id);
  Future<void> saveLocation(String id, LocationModel item);
  Future<void> deleteLocation(String id);
  Future<void> deleteAllLocation(Iterable<dynamic> keys);

  // endregion

  // region PATH

  List<PathModel> getAllPath();
  PathModel? getPath(String id);
  Future<void> savePath(String id, PathModel item);
  Future<void> deletePath(String id);
  Future<void> deleteAllPath(Iterable<dynamic> keys);

  // endregion

  // region NOTE

  List<NoteModel> getAllNote();
  NoteModel? getNote(String id);
  Future<void> saveNote(String id, NoteModel item);
  Future<void> deleteNote(String id);
  Future<void> deleteAllNote(Iterable<dynamic> keys);

  // endregion

  // region SETTING

  dynamic getSetting(String key);
  Future<void> saveSetting(String key, dynamic item);
  Future<void> deleteSetting(String key);

  // endregion

}