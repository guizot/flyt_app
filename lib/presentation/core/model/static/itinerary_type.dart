class ItineraryType {
  final String id;
  final String name;
  final String icon;

  const ItineraryType({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<ItineraryType> itineraryTypes = [
  ItineraryType(id: "travel", name: "Travel", icon: "🧳"),
  ItineraryType(id: "activity", name: "Activity", icon: "🎯"),
  ItineraryType(id: "meal", name: "Meal", icon: "🍽️"),
  ItineraryType(id: "rest", name: "Rest", icon: "🛏️"),
  ItineraryType(id: "notes", name: "Notes", icon: "📝"),
];
