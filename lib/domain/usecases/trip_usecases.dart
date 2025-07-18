import 'package:flyt_app/domain/repositories/hive_repo.dart';
import 'package:intl/intl.dart';
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

      final ongoing = allTrips.where((trip) {
        final start = formatter.parse(trip.startDate);
        final end = formatter.parse(trip.endDate);
        return now.isAfter(start) && now.isBefore(end.add(const Duration(days: 1)));
      }).toList();

      final upcoming = allTrips.where((trip) {
        final start = formatter.parse(trip.startDate);
        return now.isBefore(start);
      }).toList();

      final past = allTrips.where((trip) {
        final end = formatter.parse(trip.endDate);
        return now.isAfter(end);
      }).toList();

      // Sort if needed
      ongoing.sort((a, b) => a.startDate.compareTo(b.startDate));
      upcoming.sort((a, b) => a.startDate.compareTo(b.startDate));
      past.sort((a, b) => b.endDate.compareTo(a.endDate));

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

}