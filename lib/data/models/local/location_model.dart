import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'location_model.g.dart';

@HiveType(typeId: 8)
class LocationModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Uint8List? photoBytes;

  @HiveField(2)
  String name;

  @HiveField(3)
  String type;

  @HiveField(4)
  String address;

  @HiveField(5)
  String phone;

  @HiveField(6)
  String email;

  @HiveField(7)
  String website;

  @HiveField(8)
  String mapUrl;

  @HiveField(9)
  String? note;

  @HiveField(10)
  String tripId;

  @HiveField(11)
  DateTime createdAt;

  LocationModel({
    required this.id,
    required this.photoBytes,
    required this.name,
    required this.type,
    required this.address,
    required this.phone,
    required this.email,
    required this.website,
    required this.mapUrl,
    this.note,
    required this.tripId,
    required this.createdAt,
  });
}
