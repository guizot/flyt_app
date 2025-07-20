import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/location_model.dart';
import '../../../../data/models/local/note_model.dart';
import '../../../../data/models/local/path_model.dart';
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


  Future<void> getAllDetail(String id) async {
    emit(TripLoading());
    TripModel? trip = tripUseCases.getTrip(id);
    List<NoteModel> notes = tripUseCases.getAllNote(id);
    List<LocationModel> locations = tripUseCases.getAllLocation(id);
    List<PathModel> paths = tripUseCases.getAllPath(id);
    emit(TripDetailLoaded(
      trip: trip,
      notes: notes,
      locations: locations,
      paths: paths
    ));
  }


  NoteModel? getNote(String id) {
    emit(TripLoading());
    NoteModel? note = tripUseCases.getNote(id);
    emit(TripInitial());
    return note;
  }

  Future<void> saveNote(NoteModel item) async {
    await tripUseCases.saveNote(item);
  }

  Future<void> deleteNote(String id) async {
    emit(TripLoading());
    await tripUseCases.deleteNote(id);
    emit(TripInitial());
  }


  LocationModel? getLocationDetail(String id) {
    emit(TripLoading());
    LocationModel? location = tripUseCases.getLocation(id);
    emit(LocationDetailLoaded(location: location));
    return location;
  }

  List<LocationModel> getAllLocation(String id) {
    return tripUseCases.getAllLocation(id);
  }

  LocationModel? getLocation(String id) {
    emit(TripLoading());
    LocationModel? location = tripUseCases.getLocation(id);
    emit(TripInitial());
    return location;
  }

  Future<void> saveLocation(LocationModel item) async {
    await tripUseCases.saveLocation(item);
  }

  Future<void> deleteLocation(String id) async {
    emit(TripLoading());
    await tripUseCases.deleteLocation(id);
    emit(TripInitial());
  }


  PathModel? getPath(String id) {
    emit(TripLoading());
    PathModel? path = tripUseCases.getPath(id);
    emit(TripInitial());
    return path;
  }

  Future<void> savePath(PathModel item) async {
    await tripUseCases.savePath(item);
  }

  Future<void> deletePath(String id) async {
    emit(TripLoading());
    await tripUseCases.deletePath(id);
    emit(TripInitial());
  }

}