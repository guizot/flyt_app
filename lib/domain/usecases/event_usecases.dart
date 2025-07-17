import 'package:flyt_app/data/core/const/hive_values.dart';
import 'package:flyt_app/domain/repositories/hive_repo.dart';
import 'package:flyt_app/presentation/core/extension/event_extension.dart';
import '../../data/models/local/event_model.dart';

class EventUseCases {

  final HiveRepo hiveRepo;
  EventUseCases({required this.hiveRepo});

  List<Event> getAllEvent() {
    final events = hiveRepo.getAllEvent();
    events.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    try {
      final selectedItem = getSelectedEvent();
      final selectedId = selectedItem['id'];
      for (final e in events) {
        e.selected = (e.id == selectedId);
      }
    } catch (e) {
      if (events.isNotEmpty) {
        events.first.selected = true;
      }
    }
    return events;
  }

  Event? getEvent(String id) {
    // space for business logic (before return / before send)
    return hiveRepo.getEvent(id);
  }

  Future<void> saveEvent(Event item) async {
    final existing = getEvent(item.id);
    await hiveRepo.saveEvent(item.id, item);
    if (existing == null) {
      await putSelectedEvent(item);
    } else {
      final selected = getSelectedEvent();
      final isSelected = selected != null && selected['id'] == item.id;
      if (isSelected) {
        await putSelectedEvent(item);
      }
    }
  }

  Future<void> deleteEvent(String id) async {
    final selectedItem = getSelectedEvent();
    final selectedId = selectedItem?['id'];

    // Delete the EVENT itself
    await hiveRepo.deleteEvent(id);

    // Update selected event if needed
    if (selectedId == id) {
      final events = hiveRepo.getAllEvent();
      if (events.isNotEmpty) {
        await putSelectedEvent(events.first);
      } else {
        await hiveRepo.deleteSetting(HiveValues.eventSelected);
      }
    }
  }


  Future<void> putSelectedEvent(Event item) async {
    hiveRepo.saveSetting(HiveValues.eventSelected, item.toMap());
    getAllEvent();
  }

  dynamic getSelectedEvent() {
    return hiveRepo.getSetting(HiveValues.eventSelected);
  }


  Map<String, dynamic>? getSummaryTraveler() {
    try {
      final selected = getSelectedEvent();
      if (selected != null) {
        final eventId = selected['id'];
        final item = hiveRepo.getSetting('${HiveValues.summaryTraveler}_$eventId');
        if (item is Map) {
          return Map<String, dynamic>.from(item);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic>? getSummaryPacking() {
    try {
      final selected = getSelectedEvent();
      if (selected != null) {
        final eventId = selected['id'];
        final item = hiveRepo.getSetting('${HiveValues.summaryPacking}_$eventId');
        if (item is Map) {
          return Map<String, dynamic>.from(item);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic>? getSummaryPhrases() {
    try {
      final selected = getSelectedEvent();
      if (selected != null) {
        final eventId = selected['id'];
        final item = hiveRepo.getSetting('${HiveValues.summaryPhrases}_$eventId');
        if (item is Map) {
          return Map<String, dynamic>.from(item);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

}