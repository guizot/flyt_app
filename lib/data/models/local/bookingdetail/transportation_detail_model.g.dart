// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transportation_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportationDetailModelAdapter
    extends TypeAdapter<TransportationDetailModel> {
  @override
  final int typeId = 12;

  @override
  TransportationDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportationDetailModel(
      transportType: fields[0] as String,
      transportName: fields[1] as String,
      vehicleName: fields[2] as String,
      seatNumber: fields[3] as String,
      departureTime: fields[4] as DateTime,
      arrivalTime: fields[5] as DateTime,
      pickUpPoint: fields[6] as String,
      dropOffPoint: fields[7] as String,
      departureLocation: fields[8] as String,
      arrivalLocation: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransportationDetailModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.transportType)
      ..writeByte(1)
      ..write(obj.transportName)
      ..writeByte(2)
      ..write(obj.vehicleName)
      ..writeByte(3)
      ..write(obj.seatNumber)
      ..writeByte(4)
      ..write(obj.departureTime)
      ..writeByte(5)
      ..write(obj.arrivalTime)
      ..writeByte(6)
      ..write(obj.pickUpPoint)
      ..writeByte(7)
      ..write(obj.dropOffPoint)
      ..writeByte(8)
      ..write(obj.departureLocation)
      ..writeByte(9)
      ..write(obj.arrivalLocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportationDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
