import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/packing_model.dart';
import '../../../../domain/usecases/packing_usecases.dart';
import '../../../core/model/common/packing_group.dart';
import 'packing_state.dart';

class PackingCubit extends Cubit<PackingCubitState> {

  final PackingUseCases packingUseCases;
  PackingCubit({required this.packingUseCases}) : super(PackingInitial());

  Future<void> getAllPacking() async {
    emit(PackingLoading());
    List<PackingGroup> grouped = packingUseCases.getGroupedPacking();
    if (grouped.isEmpty) {
      emit(PackingEmpty());
    } else {
      emit(PackingGroupLoaded(groupedPackings: grouped));
    }
  }

  Future<void> selectPacking(String id) async {
    await packingUseCases.toggleSelectedPacking(id);
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

}