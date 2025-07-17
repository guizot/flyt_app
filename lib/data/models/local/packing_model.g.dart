// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packing_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackingAdapter extends TypeAdapter<Packing> {
  @override
  final int typeId = 3;

  @override
  Packing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Packing(
      id: fields[0] as String,
      name: fields[1] as String,
      group: fields[2] as String,
      groupIcon: fields[3] as String,
      selected: fields[4] as bool,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Packing obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.group)
      ..writeByte(3)
      ..write(obj.groupIcon)
      ..writeByte(4)
      ..write(obj.selected)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
