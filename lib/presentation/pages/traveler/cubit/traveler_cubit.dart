import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/traveler_model.dart';
import '../../../../domain/usecases/traveler_usecases.dart';
import 'traveler_state.dart';

class TravelerCubit extends Cubit<TravelerCubitState> {
  final TravelerUseCases travelerUseCases;
  TravelerCubit({required this.travelerUseCases}) : super(TravelerInitial());

  Future<void> getAllTraveler() async {
    emit(TravelerLoading());
    List<Traveler> travelers = travelerUseCases.getAllTraveler();
    if(travelers.isEmpty) {
      emit(TravelerEmpty());
    } else if(travelers.isNotEmpty) {
      emit(TravelerLoaded(travelers: travelers));
    }
  }

  Traveler? getTraveler(String id) {
    emit(TravelerLoading());
    Traveler? traveler = travelerUseCases.getTraveler(id);
    emit(TravelerInitial());
    return traveler;
  }

  Future<void> saveTraveler(Traveler item) async {
    await travelerUseCases.saveTraveler(item);
  }

  Future<void> deleteTraveler(String id) async {
    emit(TravelerLoading());
    await travelerUseCases.deleteTraveler(id);
    emit(TravelerInitial());
  }

  Future<void> getAllDetail(String id) async {
    emit(TravelerLoading());
    Traveler? traveler = travelerUseCases.getTraveler(id);
    //List<DocumentModel> documents = travelerUseCases.getAllDocument(id);
    emit(
        TravelerDetailLoaded(
          traveler: traveler,
          //documents: documents,
        )
    );
  }

} 