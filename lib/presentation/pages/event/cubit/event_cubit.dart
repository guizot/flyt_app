import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/domain/usecases/event_usecases.dart';
import '../../../../data/models/local/event_model.dart';
import 'event_state.dart';

class EventCubit extends Cubit<EventCubitState> {

  final EventUseCases eventUseCases;
  EventCubit({required this.eventUseCases}) : super(EventInitial());

  Future<List<Event>> getAllEvent() async {
    emit(EventLoading());
    List<Event> events = eventUseCases.getAllEvent();
    if(events.isEmpty) {
      emit(EventEmpty());
    } else if(events.isNotEmpty) {
      emit(EventLoaded(events: events));
    }
    return events;
  }

  Event? getEvent(String id) {
    emit(EventLoading());
    Event? event = eventUseCases.getEvent(id);
    emit(EventInitial());
    return event;
  }

  Future<void> saveEvent(Event item) async {
    await eventUseCases.saveEvent(item);
  }

  Future<void> deleteEvent(String id) async {
    emit(EventLoading());
    await eventUseCases.deleteEvent(id);
    emit(EventInitial());
  }

  Future<void> selectEvent(Event item) async {
    await eventUseCases.putSelectedEvent(item);
  }

  String getSelectedEventName() {
    return eventUseCases.getSelectedEvent()['title'];
  }

  Map<String, dynamic>? getSummaryTraveler() {
    return eventUseCases.getSummaryTraveler();
  }

  Map<String, dynamic>? getSummaryPacking() {
    return eventUseCases.getSummaryPacking();
  }

  Map<String, dynamic>? getSummaryPhrases() {
    return eventUseCases.getSummaryPhrases();
  }

}