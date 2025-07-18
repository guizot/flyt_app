class BloodType {
  final String id;
  final String name;
  final String icon;

  const BloodType({required this.id, required this.name, required this.icon});
}

const List<BloodType> bloodTypes = [
  BloodType(id: "A", name: "A", icon: "🅰️"),
  BloodType(id: "B", name: "B", icon: "🅱️"),
  BloodType(id: "AB", name: "AB", icon: "🆎"),
  BloodType(id: "O", name: "O", icon: "🅾️"),
];
