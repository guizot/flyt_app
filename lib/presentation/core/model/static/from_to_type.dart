class FromToType {
  final String id;
  final String name;
  final String icon;

  const FromToType({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<FromToType> fromToTypes = [
  FromToType(id: "from", name: "From", icon: "📍"),
  FromToType(id: "to", name: "To", icon: "🏁"),
];
