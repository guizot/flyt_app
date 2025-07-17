import 'package:flyt_app/domain/repositories/hive_repo.dart';
import '../../data/models/local/language_model.dart';
import '../../data/models/local/phrases_model.dart';

class PhrasesUseCases {
  final HiveRepo hiveRepo;
  PhrasesUseCases({required this.hiveRepo});

  List<LanguageModel> getAllLanguage() {
    try {
      return hiveRepo.getAllLanguage();
    } catch (e) {
      return [];
    }
  }

  LanguageModel? getLanguage(String id) {
    return hiveRepo.getLanguage(id);
  }

  Future<void> saveLanguage(LanguageModel item) async {
    await hiveRepo.saveLanguage(item.id, item);
  }

  Future<void> deleteLanguage(String id) async {
    final phrasesToDelete = hiveRepo.getAllPhrases()
        .where((phrase) => phrase.languageId == id)
        .map((phrase) => phrase.id)
        .toList();
    await hiveRepo.deleteAllPhrases(phrasesToDelete);
    await hiveRepo.deleteLanguage(id);
  }


  List<PhrasesModel> getAllPhrases(String languageId) {
    try {
      final allPhrases = hiveRepo.getAllPhrases();
      return allPhrases.where((phrase) => phrase.languageId == languageId).toList();
    } catch (e) {
      return [];
    }
  }

  List<PhrasesModel> searchPhrases(String languageId, String query) {
    try {
      final allItems = hiveRepo.getAllPhrases();
      return allItems.where((phrase) =>
        phrase.languageId == languageId && phrase.myLanguage.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } catch (e) {
      return [];
    }
  }

  PhrasesModel? getPhrases(String id) {
    return hiveRepo.getPhrases(id);
  }

  Future<void> savePhrases(PhrasesModel item) async {
    await hiveRepo.savePhrases(item.id, item);
  }

  Future<void> deletePhrases(String id) async {
    await hiveRepo.deletePhrases(id);
  }

}
