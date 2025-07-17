class TransportMode {
  final String id;
  final String name;
  final String icon;

  const TransportMode({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<TransportMode> transportModes = [
  TransportMode(id: "walk", name: "Walk", icon: "🚶"),
  TransportMode(id: "bicycle", name: "Bicycle", icon: "🚲"),
  TransportMode(id: "motorbike", name: "Motorbike", icon: "🏍️"),
  TransportMode(id: "car", name: "Car", icon: "🚗"),
  TransportMode(id: "bus", name: "Bus", icon: "🚌"),
  TransportMode(id: "train", name: "Train", icon: "🚆"),
  TransportMode(id: "ferry", name: "Ferry", icon: "⛴️"),
  TransportMode(id: "flight", name: "Flight", icon: "✈️"),
  TransportMode(id: "other", name: "Other", icon: "🧭"),
];
