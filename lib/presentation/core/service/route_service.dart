import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../pages/home.dart';
import '../../pages/packing/packing_add.dart';
import '../../pages/phrases/language_add.dart';
import '../../pages/phrases/phrases_add.dart';
import '../../pages/phrases/phrases_detail.dart';
import '../../pages/setting/setting.dart';
import '../../pages/traveler/document_add.dart';
import '../../pages/traveler/traveler_add.dart';
import '../../pages/traveler/traveler_detail.dart';
import '../../pages/trip/booking/booking_add.dart';
import '../../pages/trip/booking/booking_detail.dart';
import '../../pages/trip/itinerary/itinerary_add.dart';
import '../../pages/trip/location/location_add.dart';
import '../../pages/trip/location/location_detail.dart';
import '../../pages/trip/note/note_add.dart';
import '../../pages/trip/path/path_add.dart';
import '../../pages/trip/trip_add.dart';
import '../../pages/trip/trip_detail.dart';
import '../constant/routes_values.dart';
import '../model/arguments/common_add_args.dart';
import '../model/arguments/document_add_args.dart';
import '../model/arguments/phrases_add_args.dart';
import '../widget/image_view.dart';

class RouteService {

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesValues.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesValues.travelerAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => TravelerAddProvider(id: id));
      case RoutesValues.travelerDetail:
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => TravelerDetailPageProvider(id: id));
      case RoutesValues.documentAdd:
        var args = settings.arguments as DocumentAddArgs;
        return MaterialPageRoute(builder: (_) => DocumentAddProvider(item: args));
      case RoutesValues.packingAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => PackingAddProvider(id: id));
      case RoutesValues.languageAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => LanguageAddProvider(id: id));
      case RoutesValues.phrasesDetail:
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PhrasesDetailPageProvider(id: id));
      case RoutesValues.phrasesAdd:
        var args = settings.arguments as PhrasesAddArgs;
        return MaterialPageRoute(builder: (_) => PhrasesAddProvider(item: args));
      case RoutesValues.tripAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => TripAddProvider(id: id));
      case RoutesValues.tripDetail:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => TripDetailPageProvider(id: id));
      case RoutesValues.viewImage:
        var imageBytes = settings.arguments as Uint8List?;
        return MaterialPageRoute(builder: (_) => ImageView(imageBytes: imageBytes));
      case RoutesValues.setting:
        return MaterialPageRoute(builder: (_) => const SettingPage());
      case RoutesValues.bookingAdd:
        var args = settings.arguments as CommonAddArgs;
        return MaterialPageRoute(builder: (_) => BookingAddProvider(item: args));
      case RoutesValues.itineraryAdd:
        var args = settings.arguments as CommonAddArgs;
        return MaterialPageRoute(builder: (_) => ItineraryAddProvider(item: args));
      case RoutesValues.locationAdd:
        var args = settings.arguments as CommonAddArgs;
        return MaterialPageRoute(builder: (_) => LocationAddProvider(item: args));
      case RoutesValues.noteAdd:
        var args = settings.arguments as CommonAddArgs;
        return MaterialPageRoute(builder: (_) => NoteAddProvider(item: args));
      case RoutesValues.pathAdd:
        var args = settings.arguments as CommonAddArgs;
        return MaterialPageRoute(builder: (_) => PathAddProvider(item: args));
      case RoutesValues.bookingDetail:
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => BookingDetailPageProvider(id: id));
      case RoutesValues.locationDetail:
        var args = settings.arguments as CommonAddArgs;
        return MaterialPageRoute(builder: (_) => LocationDetailPageProvider(item: args));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text('Error page')),
          );
        });
    }
  }

}