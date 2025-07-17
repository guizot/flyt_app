class TransportationType {
  final String id;
  final String name;
  final String icon;

  const TransportationType({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<TransportationType> transportationTypes = [
  TransportationType(id: "flight", name: "Flight", icon: "✈️"),
  TransportationType(id: "train", name: "Train", icon: "🚆"),
  TransportationType(id: "ferry", name: "Ferry", icon: "⛴️"),
  TransportationType(id: "bus", name: "Bus", icon: "🚌"),
  TransportationType(id: "carRental", name: "Car Rental", icon: "🚘"),
  TransportationType(id: "privateTransfer", name: "Private Transfer", icon: "🚖"),
];
