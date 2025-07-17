class BookingCategoryType {
  final String id;
  final String name;
  final String icon;

  const BookingCategoryType({
    required this.id,
    required this.name,
    required this.icon,
  });
}

const List<BookingCategoryType> bookingCategoryTypes = [
  BookingCategoryType(id: "transportation", name: "Transportation", icon: "🚌"),
  BookingCategoryType(id: "accommodation", name: "Accommodation", icon: "🏨"),
  BookingCategoryType(id: "activity", name: "Activity", icon: "🎟️"),
];
