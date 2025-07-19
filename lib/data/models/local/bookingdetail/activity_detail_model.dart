import 'package:hive/hive.dart';
import 'booking_detail_model.dart';

part 'activity_detail_model.g.dart';

@HiveType(typeId: 14)
class ActivityDetailModel extends BookingDetailModel {

  @HiveField(0)
  String activityType;

  @HiveField(1)
  String activityName;

  @HiveField(2)
  String address;

  @HiveField(3)
  DateTime startTime;

  @HiveField(4)
  DateTime endTime;

  @HiveField(5)
  String contact;

  @HiveField(6)
  String guideName;

  ActivityDetailModel({
    required this.activityType,
    required this.activityName,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.contact,
    required this.guideName,
  });

}
