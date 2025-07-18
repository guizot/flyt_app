import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String startDate;

  @HiveField(3)
  String endDate;

  @HiveField(4)
  String description;

  @HiveField(5)
  Uint8List? photoBytes;

  @HiveField(6)
  DateTime createdAt;

  TripModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    this.photoBytes,
    required this.createdAt,
  });
}
