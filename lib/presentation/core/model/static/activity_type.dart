class ActivityType {
  final String id;
  final String name;
  final String icon;

  const ActivityType({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<ActivityType> activityTypes = [
  ActivityType(id: "trip", name: "Event", icon: "🎫"),
  ActivityType(id: "attraction", name: "Attraction", icon: "🏰"),
  ActivityType(id: "tour", name: "Tour", icon: "🗺️"),
  ActivityType(id: "playground", name: "Playground", icon: "🛝"),
  ActivityType(id: "experience", name: "Experience", icon: "🤹"),
  ActivityType(id: "reservation", name: "Reservation", icon: "📅"),
];
