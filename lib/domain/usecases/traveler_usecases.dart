import 'package:flyt_app/domain/repositories/hive_repo.dart';
import '../../data/models/local/document_model.dart';
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
    final allDocuments = hiveRepo.getAllDocument();
    final relatedKeys = allDocuments
        .where((doc) => doc.travelerId == id)
        .map((doc) => doc.id);
    await hiveRepo.deleteAllDocument(relatedKeys);
    await hiveRepo.deleteTraveler(id);
  }


  List<DocumentModel> getAllDocument(String travelerId) {
    try {
      final allDocuments = hiveRepo.getAllDocument();
      allDocuments.sort((a, b) {
        final aTime = a.createdAt;
        final bTime = b.createdAt;
        return aTime.compareTo(bTime);
      });
      return allDocuments.where((doc) => doc.travelerId == travelerId).toList();
    } catch (e) {
      return [];
    }
  }

  DocumentModel? getDocument(String id) {
    return hiveRepo.getDocument(id);
  }

  Future<void> saveDocument(DocumentModel item) async {
    await hiveRepo.saveDocument(item.id, item);
  }

  Future<void> deleteDocument(String id) async {
    await hiveRepo.deleteDocument(id);
  }

}
