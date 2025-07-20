import '../../../../data/models/local/itinerary_model.dart';

class ItineraryGroup {
  final String date;
  final List<ItineraryModel> items;

  ItineraryGroup({required this.date, required this.items});
}
