import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/trip_model.dart';
import '../../../../domain/usecases/trip_usecases.dart';
import '../trip_display_item.dart';
import 'trip_state.dart';

class TripCubit extends Cubit<TripCubitState> {

  final TripUseCases tripUseCases;
  TripCubit({required this.tripUseCases}) : super(TripInitial());

  Future<void> getAllTrip() async {
    emit(TripLoading());
    List<TripModel> trips = tripUseCases.getAllTrip();
    if(trips.isEmpty) {
      emit(TripEmpty());
    } else if(trips.isNotEmpty) {
      emit(TripLoaded(trips: trips));
    }
  }

  TripModel? getTrip(String id) {
    emit(TripLoading());
    TripModel? trip = tripUseCases.getTrip(id);
    emit(TripInitial());
    return trip;
  }

  Future<void> saveTrip(TripModel item) async {
    await tripUseCases.saveTrip(item);
  }

  Future<void> deleteTrip(String id) async {
    emit(TripLoading());
    await tripUseCases.deleteTrip(id);
    emit(TripInitial());
  }

  Future<void> searchTrip(String query) async {
    emit(TripLoading());
    List<TripModel> trips = tripUseCases.searchTrip(query);
    if (trips.isEmpty) {
      emit(TripEmpty());
    } else {
      emit(TripSearchLoaded(trips: trips));
    }
  }

  Future<void> getGroupedTrip() async {
    emit(TripLoading());
    List<TripDisplayItem> items = tripUseCases.getGroupedTrip();
    if (items.isEmpty) {
      emit(TripEmpty());
    } else {
      emit(TripGroupedLoaded(items: items));
    }
  }

}