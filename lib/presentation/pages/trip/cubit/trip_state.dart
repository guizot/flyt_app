import 'package:equatable/equatable.dart';
import '../../../../data/models/local/trip_model.dart';

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

class TripEmpty extends TripCubitState {}

class TripError extends TripCubitState {
  final String message;
  const TripError({required this.message});

  @override
  List<Object?> get props => [message];
}