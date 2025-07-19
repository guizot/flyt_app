import 'dart:typed_data';
import 'package:flyt_app/data/models/local/bookingdetail/booking_detail_model.dart';
import 'package:hive/hive.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 10)
class BookingModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String providerName;

  @HiveField(2)
  String bookingCode;

  @HiveField(3)
  String bookingType;

  @HiveField(4)
  List<Uint8List> attachments;

  @HiveField(5)
  BookingDetailModel detail;

  @HiveField(6)
  DateTime createdAt;

  BookingModel({
    required this.id,
    required this.providerName,
    required this.bookingCode,
    required this.bookingType,
    required this.attachments,
    required this.detail,
    required this.createdAt,
  });
}
