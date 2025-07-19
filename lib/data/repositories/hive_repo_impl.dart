import '../../domain/repositories/hive_repo.dart';
import '../datasource/local/hive_data_source.dart';
import '../models/local/booking_model.dart';
import '../models/local/document_model.dart';
import '../models/local/itinerary_model.dart';
import '../models/local/location_model.dart';
import '../models/local/note_model.dart';
import '../models/local/packing_model.dart';
import '../models/local/language_model.dart';
import '../models/local/path_model.dart';
import '../models/local/phrases_model.dart';
import '../models/local/traveler_model.dart';
import '../models/local/trip_model.dart';

class HiveRepoImpl implements HiveRepo {

  final HiveDataSource hiveDataSource;

  HiveRepoImpl({
    required this.hiveDataSource,
  });

  // region TRIP

  @override
  List<TripModel> getAllTrip() {
    return hiveDataSource.tripBox.values.toList();
  }

  @override
  TripModel? getTrip(String id) {
    return hiveDataSource.tripBox.get(id);
  }

  @override
  Future<void> saveTrip(String id, TripModel item) async {
    await hiveDataSource.tripBox.put(id, item);
  }

  @override
  Future<void> deleteTrip(String id) async {
    await hiveDataSource.tripBox.delete(id);
  }

  @override
  Future<void> deleteAllTrip(Iterable<dynamic> keys) async {
    await hiveDataSource.tripBox.deleteAll(keys);
  }

  // endregion

  // region TRAVELER

  @override
  List<Traveler> getAllTraveler() {
    return hiveDataSource.travelerBox.values.toList();
  }

  @override
  Traveler? getTraveler(String id) {
    return hiveDataSource.travelerBox.get(id);
  }

  @override
  Future<void> saveTraveler(String id, Traveler item) async {
    await hiveDataSource.travelerBox.put(id, item);
  }

  @override
  Future<void> deleteTraveler(String id) async {
    await hiveDataSource.travelerBox.delete(id);
  }

  @override
  Future<void> deleteAllTraveler(Iterable<dynamic> keys) async {
    await hiveDataSource.travelerBox.deleteAll(keys);
  }

  // endregion

  // region DOCUMENT

  @override
  List<DocumentModel> getAllDocument() {
    return hiveDataSource.documentBox.values.toList();
  }

  @override
  DocumentModel? getDocument(String id) {
    return hiveDataSource.documentBox.get(id);
  }

  @override
  Future<void> saveDocument(String id, DocumentModel item) async {
    await hiveDataSource.documentBox.put(id, item);
  }

  @override
  Future<void> deleteDocument(String id) async {
    await hiveDataSource.documentBox.delete(id);
  }

  @override
  Future<void> deleteAllDocument(Iterable<dynamic> keys) async {
    await hiveDataSource.documentBox.deleteAll(keys);
  }

  // endregion

  // region PACKING

  @override
  List<Packing> getAllPacking() {
    return hiveDataSource.packingBox.values.toList();
  }

  @override
  Packing? getPacking(String id) {
    return hiveDataSource.packingBox.get(id);
  }

  @override
  Future<void> savePacking(String id, Packing item) async {
    await hiveDataSource.packingBox.put(id, item);
  }

  @override
  Future<void> deletePacking(String id) async {
    await hiveDataSource.packingBox.delete(id);
  }

  @override
  Future<void> deleteAllPacking(Iterable<dynamic> keys) async {
    await hiveDataSource.packingBox.deleteAll(keys);
  }

  // endregion

  // region LANGUAGE

  @override
  List<LanguageModel> getAllLanguage() {
    return hiveDataSource.languageBox.values.toList();
  }

  @override
  LanguageModel? getLanguage(String id) {
    return hiveDataSource.languageBox.get(id);
  }

  @override
  Future<void> saveLanguage(String id, LanguageModel item) async {
    await hiveDataSource.languageBox.put(id, item);
  }

  @override
  Future<void> deleteLanguage(String id) async {
    await hiveDataSource.languageBox.delete(id);
  }

  @override
  Future<void> deleteAllLanguage(Iterable<dynamic> keys) async {
    await hiveDataSource.languageBox.deleteAll(keys);
  }

  // endregion

  // region PHRASES

  @override
  List<PhrasesModel> getAllPhrases() {
    return hiveDataSource.phrasesBox.values.toList();
  }

  @override
  PhrasesModel? getPhrases(String id) {
    return hiveDataSource.phrasesBox.get(id);
  }

  @override
  Future<void> savePhrases(String id, PhrasesModel item) async {
    await hiveDataSource.phrasesBox.put(id, item);
  }

  @override
  Future<void> deletePhrases(String id) async {
    await hiveDataSource.phrasesBox.delete(id);
  }

  @override
  Future<void> deleteAllPhrases(Iterable<dynamic> keys) async {
    await hiveDataSource.phrasesBox.deleteAll(keys);
  }

  // endregion

  // region BOOKING

  @override
  List<BookingModel> getAllBooking() {
    return hiveDataSource.bookingBox.values.toList();
  }

  @override
  BookingModel? getBooking(String id) {
    return hiveDataSource.bookingBox.get(id);
  }

  @override
  Future<void> saveBooking(String id, BookingModel item) async {
    await hiveDataSource.bookingBox.put(id, item);
  }

  @override
  Future<void> deleteBooking(String id) async {
    await hiveDataSource.bookingBox.delete(id);
  }

  @override
  Future<void> deleteAllBooking(Iterable<dynamic> keys) async {
    await hiveDataSource.bookingBox.deleteAll(keys);
  }

  // endregion

  // region ITINERARY

  @override
  List<ItineraryModel> getAllItinerary() {
    return hiveDataSource.itineraryBox.values.toList();
  }

  @override
  ItineraryModel? getItinerary(String id) {
    return hiveDataSource.itineraryBox.get(id);
  }

  @override
  Future<void> saveItinerary(String id, ItineraryModel item) async {
    await hiveDataSource.itineraryBox.put(id, item);
  }

  @override
  Future<void> deleteItinerary(String id) async {
    await hiveDataSource.itineraryBox.delete(id);
  }

  @override
  Future<void> deleteAllItinerary(Iterable<dynamic> keys) async {
    await hiveDataSource.itineraryBox.deleteAll(keys);
  }

  // endregion

  // region LOCATION

  @override
  List<LocationModel> getAllLocation() {
    return hiveDataSource.locationBox.values.toList();
  }

  @override
  LocationModel? getLocation(String id) {
    return hiveDataSource.locationBox.get(id);
  }

  @override
  Future<void> saveLocation(String id, LocationModel item) async {
    await hiveDataSource.locationBox.put(id, item);
  }

  @override
  Future<void> deleteLocation(String id) async {
    await hiveDataSource.locationBox.delete(id);
  }

  @override
  Future<void> deleteAllLocation(Iterable<dynamic> keys) async {
    await hiveDataSource.locationBox.deleteAll(keys);
  }

  // endregion

  // region PATH

  @override
  List<PathModel> getAllPath() {
    return hiveDataSource.pathBox.values.toList();
  }

  @override
  PathModel? getPath(String id) {
    return hiveDataSource.pathBox.get(id);
  }

  @override
  Future<void> savePath(String id, PathModel item) async {
    await hiveDataSource.pathBox.put(id, item);
  }

  @override
  Future<void> deletePath(String id) async {
    await hiveDataSource.pathBox.delete(id);
  }

  @override
  Future<void> deleteAllPath(Iterable<dynamic> keys) async {
    await hiveDataSource.pathBox.deleteAll(keys);
  }

  // endregion

  // region NOTE

  @override
  List<NoteModel> getAllNote() {
    return hiveDataSource.noteBox.values.toList();
  }

  @override
  NoteModel? getNote(String id) {
    return hiveDataSource.noteBox.get(id);
  }

  @override
  Future<void> saveNote(String id, NoteModel item) async {
    await hiveDataSource.noteBox.put(id, item);
  }

  @override
  Future<void> deleteNote(String id) async {
    await hiveDataSource.noteBox.delete(id);
  }

  @override
  Future<void> deleteAllNote(Iterable<dynamic> keys) async {
    await hiveDataSource.noteBox.deleteAll(keys);
  }

  // endregion

  // region SETTING

  @override
  dynamic getSetting(String key) {
    return hiveDataSource.settingBox.get(key);
  }

  @override
  Future<void> saveSetting(String key, item) async {
    await hiveDataSource.settingBox.put(key, item);
  }

  @override
  Future<void> deleteSetting(String key) async {
    await hiveDataSource.settingBox.delete(key);
  }

  // endregion

}