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

  Widget headerItem(String title, String subtitle, String bookingType, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              bookingType,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios_rounded, size: 12),
            const SizedBox(width: 4),
            Text(
              type,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const CommonSeparator(color: Colors.grey),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              color: Theme.of(context).hoverColor,
              border: Border.all(
                color: Theme.of(context).hoverColor,
                width: 1,
              ),
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
    const dateTimeFormat = 'dd MMM yyyy - HH:mm';
    const dateFormat = 'dd MMMM yyyy';
    const dayMonthFormat = 'dd MMM';
    const hourMinuteFormat = 'HH:mm';

    if(widget.item.detail is TransportationDetailModel) {
      final dtl = widget.item.detail as TransportationDetailModel;
      final date = DateFormat(dateTimeFormat).parse(dtl.departureTime);
      String dayMonth = DateFormat(dayMonthFormat).format(date);
      String hourMinute = DateFormat(hourMinuteFormat).format(date);
      headerChild = headerItem(dtl.transportName, '${dtl.departureLocation} - ${dtl.arrivalLocation}', widget.item.bookingType, dtl.transportType);
      lowerChild = lowerItem('Date', dayMonth,'Time', hourMinute, 'Code', widget.item.bookingCode);
    }
    else if(widget.item.detail is AccommodationDetailModel) {
      final dtl = widget.item.detail as AccommodationDetailModel;
      final dateCheckInParse = DateFormat(dateTimeFormat).parse(dtl.checkIn);
      String dateCheckIn = DateFormat(dateFormat).format(dateCheckInParse);
      String hourCheckIn = DateFormat(hourMinuteFormat).format(dateCheckInParse);
      final dateCheckOutParse = DateFormat(dateTimeFormat).parse(dtl.checkOut);
      String dateCheckOut = DateFormat(dateFormat).format(dateCheckOutParse);
      String hourCheckOut = DateFormat(hourMinuteFormat).format(dateCheckOutParse);
      headerChild = headerItem(dtl.accommodationName, '$dateCheckIn - $dateCheckOut', widget.item.bookingType, dtl.accommodationType);
      lowerChild = lowerItem('Check In', hourCheckIn, 'Check Out', hourCheckOut, 'Code', widget.item.bookingCode);
    }
    else if(widget.item.detail is ActivityDetailModel) {
      final dtl = widget.item.detail as ActivityDetailModel;
      final date = DateFormat(dateTimeFormat).parse(dtl.startTime);
      String dayMonth = DateFormat(dayMonthFormat).format(date);
      String hourMinute = DateFormat(hourMinuteFormat).format(date);
      headerChild = headerItem(dtl.activityName, dtl.activityType, widget.item.bookingType, dtl.activityType);
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
                border: Border.all(
                  color: Theme.of(context).hoverColor,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  headerChild,
                  const SizedBox(height: 16),
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