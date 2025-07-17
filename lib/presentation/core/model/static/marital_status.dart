class MaritalStatus {
  final String id;
  final String name;
  final String icon;

  const MaritalStatus({required this.id, required this.name, required this.icon});
}

const List<MaritalStatus> maritalStatuses = [
  MaritalStatus(id: "single", name: "Single", icon: "🧍"),
  MaritalStatus(id: "married", name: "Married", icon: "💍"),
  MaritalStatus(id: "divorced", name: "Divorced", icon: "⚡"),
  MaritalStatus(id: "widowed", name: "Widowed", icon: "🖤"),
];
