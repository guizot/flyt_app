import 'package:hive/hive.dart';

import 'location_model.dart';

part 'path_model.g.dart';

@HiveType(typeId: 7)
class PathModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String fromLocationId;

  @HiveField(2)
  String toLocationId;

  @HiveField(3)
  String distance;

  @HiveField(4)
  String estimatedTime;

  @HiveField(5)
  String transport;

  @HiveField(6)
  String tripId;

  @HiveField(7)
  DateTime createdAt;

  PathModel({
    required this.id,
    required this.fromLocationId,
    required this.toLocationId,
    required this.distance,
    required this.estimatedTime,
    required this.transport,
    required this.tripId,
    required this.createdAt,
  });

  LocationModel? getFromLocation(List<LocationModel> locations) {
    try {
      return locations.firstWhere((loc) => loc.id == fromLocationId);
    } catch (_) {
      return null;
    }
  }

  LocationModel? getToLocation(List<LocationModel> locations) {
    try {
      return locations.firstWhere((loc) => loc.id == toLocationId);
    } catch (_) {
      return null;
    }
  }

}
