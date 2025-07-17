import 'package:hive/hive.dart';

part 'phrases_model.g.dart';

@HiveType(typeId: 2)
class PhrasesModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String myLanguage;

  @HiveField(2)
  String theirLanguage;

  @HiveField(3)
  String? romanization;

  @HiveField(4)
  String languageId;

  @HiveField(5)
  DateTime createdAt;

  PhrasesModel({
    required this.id,
    required this.myLanguage,
    required this.theirLanguage,
    this.romanization,
    required this.languageId,
    required this.createdAt
  });
}
