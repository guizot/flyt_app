import 'package:hive/hive.dart';

part 'traveler_model.g.dart';

@HiveType(typeId: 1)
class Traveler extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  String budget;

  @HiveField(4)
  String description;

  @HiveField(5)
  DateTime createdAt;

  Traveler({
    required this.id,
    required this.name,
    required this.category,
    required this.budget,
    required this.description,
    required this.createdAt,
  });
} 