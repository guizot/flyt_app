import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 6)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String tripId;

  @HiveField(4)
  DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tripId,
    required this.createdAt,
  });
}
