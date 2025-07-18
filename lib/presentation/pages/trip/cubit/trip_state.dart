import 'package:equatable/equatable.dart';
import '../../../../data/models/local/note_model.dart';
import '../../../../data/models/local/trip_model.dart';
import '../trip_display_item.dart';

abstract class TripCubitState extends Equatable {
  const TripCubitState();

  @override
  List<Object?> get props => [];
}

class TripInitial extends TripCubitState {}

class TripLoading extends TripCubitState {}

class TripLoaded extends TripCubitState {
  final List<TripModel> trips;
  const TripLoaded({required this.trips});

  @override
  List<Object?> get props => [trips];
}

class TripDetailLoaded extends TripCubitState {
  final TripModel? trip;
  final List<NoteModel> notes;
  const TripDetailLoaded({required this.trip, required this.notes});

  @override
  List<Object?> get props => [trip, notes];
}

class TripGroupedLoaded extends TripCubitState {
  final List<TripDisplayItem> items;
  const TripGroupedLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class TripSearchLoaded extends TripCubitState {
  final List<TripModel> trips;
  const TripSearchLoaded({required this.trips});

  @override
  List<Object?> get props => [trips];
}

class TripEmpty extends TripCubitState {}

class TripError extends TripCubitState {
  final String message;
  const TripError({required this.message});

  @override
  List<Object?> get props => [message];
}