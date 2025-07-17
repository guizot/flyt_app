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
      birthdate: fields[2] as DateTime,
      gender: fields[3] as String,
      bloodType: fields[4] as String,
      maritalStatus: fields[5] as String,
      nationality: fields[6] as String,
      phone: fields[7] as String,
      email: fields[8] as String,
      imageBytes: fields[9] as Uint8List?,
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Traveler obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.birthdate)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.bloodType)
      ..writeByte(5)
      ..write(obj.maritalStatus)
      ..writeByte(6)
      ..write(obj.nationality)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.email)
      ..writeByte(9)
      ..write(obj.imageBytes)
      ..writeByte(10)
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
