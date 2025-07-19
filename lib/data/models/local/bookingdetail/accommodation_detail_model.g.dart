// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accommodation_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccommodationDetailModelAdapter
    extends TypeAdapter<AccommodationDetailModel> {
  @override
  final int typeId = 13;

  @override
  AccommodationDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccommodationDetailModel(
      accommodationType: fields[0] as String,
      accommodationName: fields[1] as String,
      address: fields[2] as String,
      roomType: fields[3] as String,
      roomNumber: fields[4] as String,
      checkIn: fields[5] as DateTime,
      checkOut: fields[6] as DateTime,
      contact: fields[7] as String,
      email: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccommodationDetailModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.accommodationType)
      ..writeByte(1)
      ..write(obj.accommodationName)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.roomType)
      ..writeByte(4)
      ..write(obj.roomNumber)
      ..writeByte(5)
      ..write(obj.checkIn)
      ..writeByte(6)
      ..write(obj.checkOut)
      ..writeByte(7)
      ..write(obj.contact)
      ..writeByte(8)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccommodationDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
