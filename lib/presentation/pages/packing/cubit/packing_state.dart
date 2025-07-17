import 'package:equatable/equatable.dart';
import '../../../../data/models/local/packing_model.dart';
import '../../../core/model/common/packing_group.dart';

abstract class PackingCubitState extends Equatable {
  const PackingCubitState();

  @override
  List<Object?> get props => [];
}

class PackingInitial extends PackingCubitState {}

class PackingLoading extends PackingCubitState {}

class PackingLoaded extends PackingCubitState {
  final List<Packing> packings;
  const PackingLoaded({required this.packings});

  @override
  List<Object?> get props => [packings];
}

class PackingGroupLoaded extends PackingCubitState {
  final List<PackingGroup> groupedPackings;
  const PackingGroupLoaded({required this.groupedPackings});

  @override
  List<Object?> get props => [groupedPackings];
}

class PackingEmpty extends PackingCubitState {}

class PackingError extends PackingCubitState {
  final String message;
  const PackingError({required this.message});

  @override
  List<Object?> get props => [message];
}