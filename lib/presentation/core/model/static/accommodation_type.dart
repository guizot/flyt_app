class AccommodationType {
  final String id;
  final String name;
  final String icon;

  const AccommodationType({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<AccommodationType> accommodationTypes = [
  AccommodationType(id: "hotel", name: "Hotel", icon: "🏨"),
  AccommodationType(id: "villa", name: "Villa", icon: "🏡"),
  AccommodationType(id: "apartment", name: "Apartment", icon: "🏢"),
  AccommodationType(id: "boardingHouse", name: "Boarding House", icon: "🏠"),
  AccommodationType(id: "guestHouse", name: "Guest House", icon: "🏘️"),
  AccommodationType(id: "hostel", name: "Hostel", icon: "🛏️"),
];
