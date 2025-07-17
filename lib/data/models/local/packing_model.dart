import 'package:hive/hive.dart';

part 'packing_model.g.dart';

@HiveType(typeId: 3)
class Packing extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String group;

  @HiveField(3)
  String groupIcon;

  @HiveField(4)
  bool selected;

  @HiveField(5)
  DateTime createdAt;

  Packing({
    required this.id,
    required this.name,
    required this.group,
    required this.groupIcon,
    required this.selected,
    required this.createdAt,
  });
}
