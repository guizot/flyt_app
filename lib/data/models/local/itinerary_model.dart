import 'package:hive/hive.dart';

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
  DateTime createdAt;

  ItineraryModel({
    required this.id,
    required this.date,
    required this.time,
    required this.description,
    required this.type,
    this.pathId,
    this.locationId,
    required this.createdAt,
  });
}
