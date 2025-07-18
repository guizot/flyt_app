import '../../../data/models/local/trip_model.dart';

abstract class TripDisplayItem {}

class TripHeaderItem extends TripDisplayItem {
  final String title;
  final String icon;
  TripHeaderItem(this.title, this.icon);
}

class TripContentItem extends TripDisplayItem {
  final TripModel trip;
  TripContentItem(this.trip);
}
