import 'package:hive/hive.dart';

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
}
