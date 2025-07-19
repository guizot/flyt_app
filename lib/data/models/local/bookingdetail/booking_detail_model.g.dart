// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingDetailModelAdapter extends TypeAdapter<BookingDetailModel> {
  @override
  final int typeId = 11;

  @override
  BookingDetailModel read(BinaryReader reader) {
    return BookingDetailModel();
  }

  @override
  void write(BinaryWriter writer, BookingDetailModel obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
