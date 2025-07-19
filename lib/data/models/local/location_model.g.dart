// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationModelAdapter extends TypeAdapter<LocationModel> {
  @override
  final int typeId = 8;

  @override
  LocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationModel(
      id: fields[0] as String,
      photoBytes: fields[1] as Uint8List?,
      name: fields[2] as String,
      type: fields[3] as String,
      address: fields[4] as String,
      phone: fields[5] as String,
      email: fields[6] as String,
      website: fields[7] as String,
      mapUrl: fields[8] as String,
      note: fields[9] as String?,
      tripId: fields[10] as String,
      createdAt: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocationModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.photoBytes)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.website)
      ..writeByte(8)
      ..write(obj.mapUrl)
      ..writeByte(9)
      ..write(obj.note)
      ..writeByte(10)
      ..write(obj.tripId)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
