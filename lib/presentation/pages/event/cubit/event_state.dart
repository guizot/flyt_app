import 'package:equatable/equatable.dart';
import '../../../../data/models/local/event_model.dart';

abstract class EventCubitState extends Equatable {
  const EventCubitState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends EventCubitState {}

class EventLoading extends EventCubitState {}

class EventLoaded extends EventCubitState {
  final List<Event> events;
  const EventLoaded({required this.events});

  @override
  List<Object?> get props => [events];
}

class EventEmpty extends EventCubitState {}

class EventError extends EventCubitState {
  final String message;
  const EventError({required this.message});

  @override
  List<Object?> get props => [message];
}