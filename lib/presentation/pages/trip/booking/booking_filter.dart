import 'package:flutter/material.dart';
import '../../../core/model/static/accommodation_type.dart';
import '../../../core/model/static/activity_type.dart';
import '../../../core/model/static/booking_category.dart';
import '../../../core/model/static/transportation_type.dart';
import '../../../core/widget/drop_down_item.dart';

class BookingFilter extends StatefulWidget {
  final TextEditingController bookingTypeController;
  final TextEditingController bookingTypeItemController;
  final VoidCallback onFilterApplied;

  const BookingFilter({
    super.key,
    required this.bookingTypeController,
    required this.bookingTypeItemController,
    required this.onFilterApplied,
  });

  @override
  State<BookingFilter> createState() => _BookingFilterState();
}

class _BookingFilterState extends State<BookingFilter> {
  @override
  void initState() {
    super.initState();
    widget.bookingTypeController.addListener(() {
      setState(() {}); // Rebuild when type changes
    });
  }

  @override
  void dispose() {
    widget.bookingTypeController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            height: 5.0,
            width: MediaQuery.of(context).size.width / 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.shadow,
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          const SizedBox(height: 18.0),
          const Text(
            'Booking Filter',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          DropDownItem(
            title: "Booking Type",
            controller: widget.bookingTypeController,
            items: bookingCategoryTypes
                .map((c) => {'title': c.name, 'icon': c.icon})
                .toList(),
          ),
          if (widget.bookingTypeController.text == 'Transportation')
            DropDownItem(
              title: "Transportation Type",
              controller: widget.bookingTypeItemController,
              items: transportationTypes
                  .map((c) => {'title': c.name, 'icon': c.icon})
                  .toList(),
            ),
          if (widget.bookingTypeController.text == 'Accommodation')
            DropDownItem(
              title: "Accommodation Type",
              controller: widget.bookingTypeItemController,
              items: accommodationTypes
                  .map((c) => {'title': c.name, 'icon': c.icon})
                  .toList(),
            ),
          if (widget.bookingTypeController.text == 'Activity')
            DropDownItem(
              title: "Activity Type",
              controller: widget.bookingTypeItemController,
              items: activityTypes
                  .map((c) => {'title': c.name, 'icon': c.icon})
                  .toList(),
            ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                widget.onFilterApplied();
                Navigator.pop(context);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).iconTheme.color,
                padding: const EdgeInsets.all(16.0),
              ),
              child: const Text("Filter"),
            ),
          ),
        ],
      ),
    );
  }
}
