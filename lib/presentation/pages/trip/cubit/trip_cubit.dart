import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/local/booking_model.dart';
import '../../../../data/models/local/itinerary_model.dart';
import '../../../../data/models/local/location_model.dart';
import '../../../../data/models/local/note_model.dart';
import '../../../../data/models/local/path_model.dart';
import '../../../../data/models/local/trip_model.dart';
import '../../../../domain/usecases/trip_usecases.dart';
import '../../../core/model/common/itinerary_group.dart';
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
    List<ItineraryGroup> itineraries = tripUseCases.getAllItinerary(id);
    List<BookingModel> bookings = tripUseCases.getAllBooking(id);
    List<LocationModel> locations = tripUseCases.getAllLocation(id);
    List<PathModel> paths = tripUseCases.getAllPath(id);
    List<NoteModel> notes = tripUseCases.getAllNote(id);
    emit(TripDetailLoaded(
      trip: trip,
      itineraries: itineraries,
      bookings: bookings,
      locations: locations,
      paths: paths,
      notes: notes,
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


  List<PathModel> getAllPath(String id) {
    return tripUseCases.getAllPath(id);
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


  ItineraryModel? getItinerary(String id) {
    emit(TripLoading());
    ItineraryModel? path = tripUseCases.getItinerary(id);
    emit(TripInitial());
    return path;
  }

  Future<void> saveItinerary(ItineraryModel item) async {
    await tripUseCases.saveItinerary(item);
  }

  Future<void> deleteItinerary(String id) async {
    emit(TripLoading());
    await tripUseCases.deleteItinerary(id);
    emit(TripInitial());
  }


  Future<void> getBookingDetail(String id) async {
    emit(TripLoading());
    BookingModel? booking = tripUseCases.getBooking(id);
    emit(BookingDetailLoaded(booking: booking));
  }

  BookingModel? getBooking(String id) {
    emit(TripLoading());
    BookingModel? path = tripUseCases.getBooking(id);
    emit(TripInitial());
    return path;
  }

  Future<void> saveBooking(BookingModel item) async {
    await tripUseCases.saveBooking(item);
  }

  Future<void> deleteBooking(String id) async {
    emit(TripLoading());
    await tripUseCases.deleteBooking(id);
    emit(TripInitial());
  }

}