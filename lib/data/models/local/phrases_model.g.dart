// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phrases_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhrasesModelAdapter extends TypeAdapter<PhrasesModel> {
  @override
  final int typeId = 2;

  @override
  PhrasesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhrasesModel(
      id: fields[0] as String,
      myLanguage: fields[1] as String,
      theirLanguage: fields[2] as String,
      romanization: fields[3] as String?,
      languageId: fields[4] as String,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PhrasesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.myLanguage)
      ..writeByte(2)
      ..write(obj.theirLanguage)
      ..writeByte(3)
      ..write(obj.romanization)
      ..writeByte(4)
      ..write(obj.languageId)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhrasesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
