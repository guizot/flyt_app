import '../../../../data/models/local/packing_model.dart';

class PackingGroup {
  final String group;
  final String groupIcon;
  final List<Packing> items;

  PackingGroup({
    required this.group,
    required this.groupIcon,
    required this.items,
  });
}