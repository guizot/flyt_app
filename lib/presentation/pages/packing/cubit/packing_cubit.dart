import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/packing_model.dart';
import '../../../../domain/usecases/packing_usecases.dart';
import 'packing_state.dart';

class PackingCubit extends Cubit<PackingCubitState> {

  final PackingUseCases packingUseCases;
  PackingCubit({required this.packingUseCases}) : super(PackingInitial());

  Future<void> getAllPacking() async {
    emit(PackingLoading());
    List<Packing> packings = packingUseCases.getAllPacking();
    if(packings.isEmpty) {
      emit(PackingEmpty());
    } else if(packings.isNotEmpty) {
      emit(PackingLoaded(packings: packings));
    }
  }

  Packing? getPacking(String id) {
    emit(PackingLoading());
    Packing? event = packingUseCases.getPacking(id);
    emit(PackingInitial());
    return event;
  }

  Future<void> savePacking(Packing item) async {
    await packingUseCases.savePacking(item);
  }

  Future<void> deletePacking(String id) async {
    await packingUseCases.deletePacking(id);
  }

  String? getSelectedEventId() {
    try {
      return packingUseCases.getSelectedEvent()['id'];
    } catch(e) {
      return null;
    }
  }

}