import 'package:flyt_app/domain/repositories/hive_repo.dart';
import '../../data/core/const/hive_values.dart';
import '../../data/models/local/packing_model.dart';

class PackingUseCases {

  final HiveRepo hiveRepo;
  PackingUseCases({required this.hiveRepo});

  List<Packing> getAllPacking() {
    try {
      final allPackings = hiveRepo.getAllPacking();
      allPackings.sort((a, b) {
        final aTime = a.createdAt;
        final bTime = b.createdAt;
        return bTime.compareTo(aTime);
      });
      return allPackings;
    } catch (e) {
      return [];
    }
  }

  Packing? getPacking(String id) {
    // space for business logic (before return / before send)
    return hiveRepo.getPacking(id);
  }

  Future<void> savePacking(Packing item) async {
    await hiveRepo.savePacking(item.id, item);
  }

  Future<void> deletePacking(String id) async {
    await hiveRepo.deletePacking(id);
  }


  Future<void> saveSummaryPacking(String eventId, Map<String, dynamic> summary) async {
    await hiveRepo.saveSetting('${HiveValues.summaryPacking}_$eventId', summary);
  }

  dynamic getSelectedEvent() {
    return hiveRepo.getSetting(HiveValues.eventSelected);
  }

}