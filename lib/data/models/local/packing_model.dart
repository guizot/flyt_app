import 'package:hive/hive.dart';

part 'packing_model.g.dart';

@HiveType(typeId: 3)
class Packing extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  String packingPackage;

  @HiveField(4)
  String confirm;

  @HiveField(5)
  DateTime createdAt;

  Packing({
    required this.id,
    required this.name,
    required this.category,
    required this.packingPackage,
    required this.confirm,
    required this.createdAt,
  });
}
