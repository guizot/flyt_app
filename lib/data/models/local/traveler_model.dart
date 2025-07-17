import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'traveler_model.g.dart';

@HiveType(typeId: 1)
class Traveler extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime birthdate;

  @HiveField(3)
  String gender;

  @HiveField(4)
  String bloodType;

  @HiveField(5)
  String maritalStatus;

  @HiveField(6)
  String nationality;

  @HiveField(7)
  String phone;

  @HiveField(8)
  String email;

  @HiveField(9)
  Uint8List? imageBytes;

  @HiveField(10)
  DateTime createdAt;

  Traveler({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.gender,
    required this.bloodType,
    required this.maritalStatus,
    required this.nationality,
    required this.phone,
    required this.email,
    this.imageBytes,
    required this.createdAt,
  });
} 