import 'package:flyt_app/domain/repositories/hive_repo.dart';
import '../../data/models/local/packing_model.dart';
import '../../presentation/core/model/common/packing_group.dart';

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

  List<PackingGroup> getGroupedPacking() {
    try {
      final allPackings = hiveRepo.getAllPacking();

      // Sort by createdAt (descending) before grouping
      allPackings.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      // Group by `group` name
      final Map<String, List<Packing>> groupedMap = {};

      for (var packing in allPackings) {
        groupedMap.putIfAbsent(packing.group, () => []).add(packing);
      }

      final List<PackingGroup> groupedList = groupedMap.entries.map((entry) {
        final items = entry.value;

        // 🔽 Sort items in this group by name
        items.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

        final firstItem = items.first;
        return PackingGroup(
          group: entry.key,
          groupIcon: firstItem.groupIcon,
          items: items,
        );
      }).toList();

      // 🔽 Optional: sort group names alphabetically
      groupedList.sort((a, b) => a.group.toLowerCase().compareTo(b.group.toLowerCase()));

      return groupedList;
    } catch (e) {
      return [];
    }
  }


  Future<void> toggleSelectedPacking(String id) async {
    final item = hiveRepo.getPacking(id);
    if (item != null) {
      item.selected = !item.selected;
      await hiveRepo.savePacking(id, item);
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

}