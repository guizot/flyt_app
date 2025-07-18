import 'package:flyt_app/domain/repositories/hive_repo.dart';
import '../../data/models/local/traveler_model.dart';

class TravelerUseCases {
  final HiveRepo hiveRepo;
  TravelerUseCases({required this.hiveRepo});

  List<Traveler> getAllTraveler() {
    try {
      final allTravelers = hiveRepo.getAllTraveler();
      allTravelers.sort((a, b) {
        final aTime = a.createdAt;
        final bTime = b.createdAt;
        return bTime.compareTo(aTime);
      });
      return allTravelers;
    } catch (e) {
      return [];
    }
  }

  Traveler? getTraveler(String id) {
    return hiveRepo.getTraveler(id);
  }

  Future<void> saveTraveler(Traveler item) async {
    await hiveRepo.saveTraveler(item.id, item);
  }

  Future<void> deleteTraveler(String id) async {
    await hiveRepo.deleteTraveler(id);
  }

} 