// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traveler_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelerAdapter extends TypeAdapter<Traveler> {
  @override
  final int typeId = 1;

  @override
  Traveler read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Traveler(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
      budget: fields[3] as String,
      description: fields[4] as String,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Traveler obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.budget)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
