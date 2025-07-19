import 'package:hive/hive.dart';
import 'booking_detail_model.dart';

part 'transportation_detail_model.g.dart';

@HiveType(typeId: 12)
class TransportationDetailModel extends BookingDetailModel {

  @HiveField(0)
  String transportType;

  @HiveField(1)
  String transportName;

  @HiveField(2)
  String vehicleName;

  @HiveField(3)
  String seatNumber;

  @HiveField(4)
  DateTime departureTime;

  @HiveField(5)
  DateTime arrivalTime;

  @HiveField(6)
  String pickUpPoint;

  @HiveField(7)
  String dropOffPoint;

  @HiveField(8)
  String departureLocation;

  @HiveField(9)
  String arrivalLocation;

  TransportationDetailModel({
    required this.transportType,
    required this.transportName,
    required this.vehicleName,
    required this.seatNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.pickUpPoint,
    required this.dropOffPoint,
    required this.departureLocation,
    required this.arrivalLocation,
  });
}
