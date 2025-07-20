import 'package:flyt_app/data/models/local/note_model.dart';
import 'package:flyt_app/domain/repositories/hive_repo.dart';
import 'package:intl/intl.dart';
import '../../data/models/local/booking_model.dart';
import '../../data/models/local/itinerary_model.dart';
import '../../data/models/local/location_model.dart';
import '../../data/models/local/path_model.dart';
import '../../data/models/local/trip_model.dart';
import '../../presentation/pages/trip/trip_display_item.dart';

class TripUseCases {

  final HiveRepo hiveRepo;
  TripUseCases({required this.hiveRepo});

  List<TripModel> getAllTrip() {
    return hiveRepo.getAllTrip();
  }

  TripModel? getTrip(String id) {
    return hiveRepo.getTrip(id);
  }

  Future<void> saveTrip(TripModel item) async {
    await hiveRepo.saveTrip(item.id, item);
  }

  Future<void> deleteTrip(String id) async {
    await hiveRepo.deleteTrip(id);
  }

  List<TripModel> searchTrip(String query) {
    try {
      final allItems = hiveRepo.getAllTrip();
      return allItems.where((phrase) =>
        phrase.title.toLowerCase().contains(query.toLowerCase())
      ).toList();
    } catch (e) {
      return [];
    }
  }

  List<TripDisplayItem> getGroupedTrip() {
    try {
      final now = DateTime.now();
      final allTrips = hiveRepo.getAllTrip();

      final formatter = DateFormat('dd MMM yyyy');

      List<TripModel> ongoing = [];
      List<TripModel> upcoming = [];
      List<TripModel> past = [];

      for (final trip in allTrips) {
        final start = formatter.parse(trip.startDate);
        final end = formatter.parse(trip.endDate);

        if (now.isAfter(start.subtract(const Duration(days: 1))) && now.isBefore(end.add(const Duration(days: 1)))) {
          ongoing.add(trip);
        } else if (now.isBefore(start)) {
          upcoming.add(trip);
        } else {
          past.add(trip);
        }
      }

      // Sort if needed
      ongoing.sort((a, b) => b.startDate.compareTo(a.startDate));
      upcoming.sort((a, b) => b.startDate.compareTo(a.startDate));
      past.sort((a, b) => a.endDate.compareTo(b.endDate));

      List<TripDisplayItem> result = [];

      if (ongoing.isNotEmpty) {
        result.add(TripHeaderItem("On Going Trips", '✈️'));
        result.addAll(ongoing.map((t) => TripContentItem(t)));
      }

      if (upcoming.isNotEmpty) {
        result.add(TripHeaderItem("Upcoming Trips", '🗓️'));
        result.addAll(upcoming.map((t) => TripContentItem(t)));
      }

      if (past.isNotEmpty) {
        result.add(TripHeaderItem("Past Trips", '🕘'));
        result.addAll(past.map((t) => TripContentItem(t)));
      }

      return result;
    } catch (e) {
      return [];
    }
  }


  List<NoteModel> getAllNote(String tripId) {
    final notes = hiveRepo
        .getAllNote()
        .where((note) => note.tripId == tripId)
        .toList();
    notes.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return notes;
  }

  NoteModel? getNote(String id) {
    return hiveRepo.getNote(id);
  }

  Future<void> saveNote(NoteModel item) async {
    await hiveRepo.saveNote(item.id, item);
  }

  Future<void> deleteNote(String id) async {
    await hiveRepo.deleteNote(id);
  }


  List<LocationModel> getAllLocation(String tripId) {
    final locations = hiveRepo
        .getAllLocation()
        .where((location) => location.tripId == tripId)
        .toList();
    locations.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return locations;
  }

  LocationModel? getLocation(String id) {
    return hiveRepo.getLocation(id);
  }

  Future<void> saveLocation(LocationModel item) async {
    await hiveRepo.saveLocation(item.id, item);
  }

  Future<void> deleteLocation(String id) async {
    await hiveRepo.deleteLocation(id);
  }


  List<PathModel> getAllPath(String tripId) {
    final paths = hiveRepo
        .getAllPath()
        .where((path) => path.tripId == tripId)
        .toList();
    paths.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return paths;
  }

  PathModel? getPath(String id) {
    return hiveRepo.getPath(id);
  }

  Future<void> savePath(PathModel item) async {
    await hiveRepo.savePath(item.id, item);
  }

  Future<void> deletePath(String id) async {
    await hiveRepo.deletePath(id);
  }


  List<ItineraryModel> getAllItinerary(String tripId) {
    final itineraries = hiveRepo
        .getAllItinerary()
        .where((itinerary) => itinerary.tripId == tripId)
        .toList();
    itineraries.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return itineraries;
  }

  ItineraryModel? getItinerary(String id) {
    return hiveRepo.getItinerary(id);
  }

  Future<void> saveItinerary(ItineraryModel item) async {
    await hiveRepo.saveItinerary(item.id, item);
  }

  Future<void> deleteItinerary(String id) async {
    await hiveRepo.deleteItinerary(id);
  }


  List<BookingModel> getAllBooking(String tripId) {
    final bookings = hiveRepo
        .getAllBooking()
        .where((booking) => booking.tripId == tripId)
        .toList();
    bookings.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return bookings;
  }

  BookingModel? getBooking(String id) {
    return hiveRepo.getBooking(id);
  }

  Future<void> saveBooking(BookingModel item) async {
    await hiveRepo.saveBooking(item.id, item);
  }

  Future<void> deleteBooking(String id) async {
    await hiveRepo.deleteItinerary(id);
  }

}