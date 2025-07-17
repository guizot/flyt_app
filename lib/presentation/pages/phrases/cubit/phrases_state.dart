import 'package:equatable/equatable.dart';
import '../../../../data/models/local/language_model.dart';
import '../../../../data/models/local/phrases_model.dart';

abstract class PhrasesCubitState extends Equatable {
  const PhrasesCubitState();

  @override
  List<Object?> get props => [];
}

// PHRASES STATES

class PhrasesInitial extends PhrasesCubitState {}

class PhrasesLoading extends PhrasesCubitState {}

class PhrasesLoaded extends PhrasesCubitState {
  final List<PhrasesModel> phrases;
  const PhrasesLoaded({required this.phrases});

  @override
  List<Object?> get props => [phrases];
}

class PhrasesEmpty extends PhrasesCubitState {}

class PhrasesError extends PhrasesCubitState {
  final String message;
  const PhrasesError({required this.message});

  @override
  List<Object?> get props => [message];
}

// LANGUAGE STATES

class LanguageLoaded extends PhrasesCubitState {
  final List<LanguageModel> languages;
  const LanguageLoaded({required this.languages});

  @override
  List<Object?> get props => [languages];
}