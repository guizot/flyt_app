// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityDetailModelAdapter extends TypeAdapter<ActivityDetailModel> {
  @override
  final int typeId = 14;

  @override
  ActivityDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityDetailModel(
      activityType: fields[0] as String,
      activityName: fields[1] as String,
      address: fields[2] as String,
      startTime: fields[3] as DateTime,
      endTime: fields[4] as DateTime,
      contact: fields[5] as String,
      guideName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityDetailModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.activityType)
      ..writeByte(1)
      ..write(obj.activityName)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.contact)
      ..writeByte(6)
      ..write(obj.guideName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
