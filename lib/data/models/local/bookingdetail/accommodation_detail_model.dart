import 'package:hive/hive.dart';
import 'booking_detail_model.dart';

part 'accommodation_detail_model.g.dart';

@HiveType(typeId: 13)
class AccommodationDetailModel extends BookingDetailModel {

  @HiveField(0)
  String accommodationType;

  @HiveField(1)
  String accommodationName;

  @HiveField(2)
  String address;

  @HiveField(3)
  String roomType;

  @HiveField(4)
  String roomNumber;

  @HiveField(5)
  DateTime checkIn;

  @HiveField(6)
  DateTime checkOut;

  @HiveField(7)
  String contact;

  @HiveField(8)
  String email;

  AccommodationDetailModel({
    required this.accommodationType,
    required this.accommodationName,
    required this.address,
    required this.roomType,
    required this.roomNumber,
    required this.checkIn,
    required this.checkOut,
    required this.contact,
    required this.email,
  });
}
