// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItineraryModelAdapter extends TypeAdapter<ItineraryModel> {
  @override
  final int typeId = 9;

  @override
  ItineraryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItineraryModel(
      id: fields[0] as String,
      date: fields[1] as String,
      time: fields[2] as String,
      description: fields[3] as String,
      type: fields[4] as String,
      pathId: fields[5] as String?,
      locationId: fields[6] as String?,
      tripId: fields[7] as String,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ItineraryModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.pathId)
      ..writeByte(6)
      ..write(obj.locationId)
      ..writeByte(7)
      ..write(obj.tripId)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItineraryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
