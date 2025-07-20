import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/booking_model.dart';
import 'package:flyt_app/data/models/local/bookingdetail/accommodation_detail_model.dart';
import 'package:flyt_app/data/models/local/bookingdetail/activity_detail_model.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/local/bookingdetail/transportation_detail_model.dart';
import '../../../core/widget/common_separator.dart';

class BookingItem extends StatefulWidget {
  const BookingItem({super.key, required this.item, required this.onTap });
  final BookingModel item;
  final Function(String) onTap;

  @override
  State<BookingItem> createState() => _BookingItemState();
}

class _BookingItemState extends State<BookingItem> {

  Widget headerItem(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        const Icon(Icons.arrow_forward_ios_rounded, size: 20),
      ],
    );
  }

  Widget lowerItem(
      String key1,
      String value1,
      String key2,
      String value2,
      String key3,
      String value3,
      ) {
    return Row(
        children: [
          blockItem(key1, value1),
          const SizedBox(width: 8),
          blockItem(key2, value2),
          const SizedBox(width: 8),
          blockItem(key3, value3),
        ],
      );
  }

  Widget blockItem(String key, String value) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              color: Theme.of(context).hoverColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    Widget headerChild = Container();
    Widget lowerChild = Container();

    if(widget.item.detail is TransportationDetailModel) {
      final dtl = widget.item.detail as TransportationDetailModel;
      String dayMonth = DateFormat('dd MMM').format(dtl.departureTime);
      String hourMinute = DateFormat('HH:mm').format(dtl.departureTime);
      headerChild = headerItem(dtl.transportName, '${dtl.departureLocation} - ${dtl.arrivalLocation}');
      lowerChild = lowerItem('Date', dayMonth,'Time', hourMinute, 'Code', widget.item.bookingCode);
    }
    else if(widget.item.detail is AccommodationDetailModel) {
      final dtl = widget.item.detail as AccommodationDetailModel;
      String dateCheckIn = DateFormat('dd MMMM yyyy').format(dtl.checkIn);
      String dateCheckOut = DateFormat('dd MMMM yyyy').format(dtl.checkOut);
      String hourCheckIn = DateFormat('HH:mm').format(dtl.checkIn);
      String hourCheckOut = DateFormat('HH:mm').format(dtl.checkOut);
      headerChild = headerItem(dtl.accommodationName, '$dateCheckIn - $dateCheckOut');
      lowerChild = lowerItem('Check-In', hourCheckIn, 'Check-Out', hourCheckOut, 'Code', widget.item.bookingCode);
    }
    else if(widget.item.detail is ActivityDetailModel) {
      final dtl = widget.item.detail as ActivityDetailModel;
      String dayMonth = DateFormat('dd MMM').format(dtl.startTime);
      String hourMinute = DateFormat('HH:mm').format(dtl.startTime);
      headerChild = headerItem(dtl.activityName, dtl.activityType);
      lowerChild = lowerItem('Date', dayMonth,'Time', hourMinute, 'Code', widget.item.bookingCode);
    }

    return GestureDetector(
      onTap: () => widget.onTap(widget.item.id),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                color: Theme.of(context).hoverColor,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  headerChild,
                  const CommonSeparator(color: Colors.grey),
                  lowerChild
                ],
              )
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );

  }

}