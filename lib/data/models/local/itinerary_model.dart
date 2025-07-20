import 'package:flyt_app/data/models/local/path_model.dart';
import 'package:hive/hive.dart';

import 'location_model.dart';

part 'itinerary_model.g.dart';

@HiveType(typeId: 9)
class ItineraryModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String date;

  @HiveField(2)
  String time;

  @HiveField(3)
  String description;

  @HiveField(4)
  String type;

  @HiveField(5)
  String? pathId;

  @HiveField(6)
  String? locationId;

  @HiveField(7)
  String tripId;

  @HiveField(8)
  DateTime createdAt;

  ItineraryModel({
    required this.id,
    required this.date,
    required this.time,
    required this.description,
    required this.type,
    this.pathId,
    this.locationId,
    required this.tripId,
    required this.createdAt,
  });

  LocationModel? getLocation(List<LocationModel> locations) {
    try {
      return locations.firstWhere((loc) => loc.id == locationId);
    } catch (_) {
      return null;
    }
  }

  PathModel? getPath(List<PathModel> paths) {
    try {
      return paths.firstWhere((path) => path.id == pathId);
    } catch (_) {
      return null;
    }
  }
}
