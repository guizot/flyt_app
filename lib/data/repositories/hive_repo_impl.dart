import 'package:flyt_app/data/models/local/event_model.dart';
import '../../domain/repositories/hive_repo.dart';
import '../datasource/local/hive_data_source.dart';
import '../models/local/document_model.dart';
import '../models/local/packing_model.dart';
import '../models/local/language_model.dart';
import '../models/local/phrases_model.dart';
import '../models/local/traveler_model.dart';

class HiveRepoImpl implements HiveRepo {

  final HiveDataSource hiveDataSource;

  HiveRepoImpl({
    required this.hiveDataSource,
  });

  // region EVENT

  @override
  List<Event> getAllEvent() {
    return hiveDataSource.eventBox.values.toList();
  }

  @override
  Event? getEvent(String id) {
    return hiveDataSource.eventBox.get(id);
  }

  @override
  Future<void> saveEvent(String id, Event item) async {
    await hiveDataSource.eventBox.put(id, item);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await hiveDataSource.eventBox.delete(id);
  }

  @override
  Future<void> deleteAllEvent(Iterable<dynamic> keys) async {
    await hiveDataSource.eventBox.deleteAll(keys);
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