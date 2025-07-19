// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PathModelAdapter extends TypeAdapter<PathModel> {
  @override
  final int typeId = 7;

  @override
  PathModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PathModel(
      id: fields[0] as String,
      fromLocationId: fields[1] as String,
      toLocationId: fields[2] as String,
      distance: fields[3] as String,
      estimatedTime: fields[4] as String,
      transport: fields[5] as String,
      tripId: fields[6] as String,
      createdAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PathModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fromLocationId)
      ..writeByte(2)
      ..write(obj.toLocationId)
      ..writeByte(3)
      ..write(obj.distance)
      ..writeByte(4)
      ..write(obj.estimatedTime)
      ..writeByte(5)
      ..write(obj.transport)
      ..writeByte(6)
      ..write(obj.tripId)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PathModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
