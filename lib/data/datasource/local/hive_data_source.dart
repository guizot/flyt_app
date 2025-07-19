import 'package:flyt_app/data/models/local/itinerary_model.dart';
import 'package:flyt_app/data/models/local/location_model.dart';
import 'package:flyt_app/data/models/local/note_model.dart';
import 'package:flyt_app/data/models/local/path_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/local/booking_model.dart';
import '../../models/local/bookingdetail/accommodation_detail_model.dart';
import '../../models/local/bookingdetail/activity_detail_model.dart';
import '../../models/local/bookingdetail/booking_detail_model.dart';
import '../../models/local/bookingdetail/transportation_detail_model.dart';
import '../../models/local/document_model.dart';
import '../../models/local/trip_model.dart';
import '../../models/local/packing_model.dart';
import '../../models/local/language_model.dart';
import '../../models/local/phrases_model.dart';
import '../../models/local/traveler_model.dart';

class HiveDataSource {

  /// Init Hive Local Storage
  static Future<void> init() async {
    await Hive.initFlutter();

    /// Define the adapters
    Hive.registerAdapter(TripModelAdapter());
    Hive.registerAdapter(TravelerAdapter());
    Hive.registerAdapter(PackingAdapter());
    Hive.registerAdapter(LanguageModelAdapter());
    Hive.registerAdapter(PhrasesModelAdapter());
    Hive.registerAdapter(DocumentModelAdapter());

    Hive.registerAdapter(BookingModelAdapter());
    Hive.registerAdapter(ItineraryModelAdapter());
    Hive.registerAdapter(LocationModelAdapter());
    Hive.registerAdapter(PathModelAdapter());
    Hive.registerAdapter(NoteModelAdapter());

    Hive.registerAdapter(BookingDetailModelAdapter());
    Hive.registerAdapter(TransportationDetailModelAdapter());
    Hive.registerAdapter(AccommodationDetailModelAdapter());
    Hive.registerAdapter(ActivityDetailModelAdapter());


    /// Open the boxes
    await Hive.openBox<TripModel>('tripBox');
    await Hive.openBox<Traveler>('travelerBox');
    await Hive.openBox<Packing>('packingBox');
    await Hive.openBox<LanguageModel>('languageBox');
    await Hive.openBox<PhrasesModel>('phrasesBox');
    await Hive.openBox<DocumentModel>('documentBox');
    await Hive.openBox<BookingModel>('bookingBox');
    await Hive.openBox<ItineraryModel>('itineraryBox');
    await Hive.openBox<LocationModel>('locationBox');
    await Hive.openBox<PathModel>('pathBox');
    await Hive.openBox<NoteModel>('noteBox');
    await Hive.openBox('settingBox');
  }

  /// Get the boxes
  Box<TripModel> get tripBox => Hive.box<TripModel>('tripBox');
  Box<Traveler> get travelerBox => Hive.box<Traveler>('travelerBox');
  Box<Packing> get packingBox => Hive.box<Packing>('packingBox');
  Box<LanguageModel> get languageBox => Hive.box<LanguageModel>('languageBox');
  Box<PhrasesModel> get phrasesBox => Hive.box<PhrasesModel>('phrasesBox');
  Box<DocumentModel> get documentBox => Hive.box<DocumentModel>('documentBox');
  Box<BookingModel> get bookingBox => Hive.box<BookingModel>('bookingBox');
  Box<ItineraryModel> get itineraryBox => Hive.box<ItineraryModel>('itineraryBox');
  Box<LocationModel> get locationBox => Hive.box<LocationModel>('locationBox');
  Box<PathModel> get pathBox => Hive.box<PathModel>('pathBox');
  Box<NoteModel> get noteBox => Hive.box<NoteModel>('noteBox');
  Box get settingBox => Hive.box('settingBox');

}