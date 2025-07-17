import 'package:hive/hive.dart';

part 'event_model.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String budget;

  @HiveField(3)
  String description;

  @HiveField(4)
  DateTime createdAt;

  bool selected = false;

  Event({
    required this.id,
    required this.title,
    required this.budget,
    required this.description,
    required this.createdAt,
    this.selected = false,
  });
}
