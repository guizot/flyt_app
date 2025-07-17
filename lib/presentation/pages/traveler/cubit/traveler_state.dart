import 'package:equatable/equatable.dart';
import '../../../../data/models/local/traveler_model.dart';

abstract class TravelerCubitState extends Equatable {
  const TravelerCubitState();

  @override
  List<Object?> get props => [];
}

class TravelerInitial extends TravelerCubitState {}

class TravelerLoading extends TravelerCubitState {}

class TravelerLoaded extends TravelerCubitState {
  final List<Traveler> travelers;
  const TravelerLoaded({required this.travelers});

  @override
  List<Object?> get props => [travelers];
}

class TravelerEmpty extends TravelerCubitState {}

class TravelerError extends TravelerCubitState {
  final String message;
  const TravelerError({required this.message});

  @override
  List<Object?> get props => [message];
} 