import 'package:hive/hive.dart';

part 'language_model.g.dart';

@HiveType(typeId: 4)
class LanguageModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String language;

  @HiveField(2)
  DateTime createdAt;

  LanguageModel({required this.id, required this.language, required this.createdAt});
}
