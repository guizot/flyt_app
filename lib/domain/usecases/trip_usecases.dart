import 'package:flyt_app/domain/repositories/hive_repo.dart';
import '../../data/models/local/trip_model.dart';

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


}