import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/language_model.dart';
import '../../../../data/models/local/phrases_model.dart';
import '../../../../domain/usecases/phrases_usecases.dart';
import 'phrases_state.dart';

class PhrasesCubit extends Cubit<PhrasesCubitState> {

  final PhrasesUseCases phrasesUseCases;
  PhrasesCubit({required this.phrasesUseCases}) : super(PhrasesInitial());

  Future<void> getAllLanguage() async {
    emit(PhrasesLoading());
    List<LanguageModel> languages = phrasesUseCases.getAllLanguage();
    if(languages.isEmpty) {
      emit(PhrasesEmpty());
    } else if(languages.isNotEmpty) {
      emit(LanguageLoaded(languages: languages));
    }
  }

  LanguageModel? getLanguage(String id) {
    emit(PhrasesLoading());
    LanguageModel? language = phrasesUseCases.getLanguage(id);
    emit(PhrasesInitial());
    return language;
  }

  Future<void> saveLanguage(LanguageModel item) async {
    await phrasesUseCases.saveLanguage(item);
  }

  Future<void> deleteLanguage(String id) async {
    await phrasesUseCases.deleteLanguage(id);
  }

  Future<void> getAllPhrases(String languageId) async {
    emit(PhrasesLoading());
    List<PhrasesModel> phrases = phrasesUseCases.getAllPhrases(languageId);
    if(phrases.isEmpty) {
      emit(PhrasesEmpty());
    } else if(phrases.isNotEmpty) {
      emit(PhrasesLoaded(phrases: phrases));
    }
  }

  Future<void> searchPhrases(String languageId, String query) async {
    emit(PhrasesLoading());
    List<PhrasesModel> phrases = phrasesUseCases.searchPhrases(languageId, query);
    if (phrases.isEmpty) {
      emit(PhrasesEmpty());
    } else {
      emit(PhrasesLoaded(phrases: phrases));
    }
  }

  PhrasesModel? getPhrases(String id) {
    emit(PhrasesLoading());
    PhrasesModel? event = phrasesUseCases.getPhrases(id);
    emit(PhrasesInitial());
    return event;
  }

  Future<void> savePhrases(PhrasesModel item) async {
    await phrasesUseCases.savePhrases(item);
  }

  Future<void> deletePhrases(String id) async {
    await phrasesUseCases.deletePhrases(id);
  }

}