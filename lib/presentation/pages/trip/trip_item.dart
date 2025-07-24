import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/trip_model.dart';
import 'package:intl/intl.dart';

class TripItem extends StatefulWidget {
  const TripItem({super.key, required this.item, required this.onTap });
  final TripModel item;
  final Function(String) onTap;

  @override
  State<TripItem> createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {

  String formatTripDate(String start, String end) {
    final inputFormat = DateFormat('dd MMM yyyy');
    final startDate = inputFormat.parse(start);
    final endDate = inputFormat.parse(end);

    if (startDate == endDate) {
      return DateFormat('dd MMM yyyy').format(startDate);
    } else if (startDate.year == endDate.year) {
      if (startDate.month == endDate.month) {
        return "${DateFormat('dd').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}";
      } else {
        return "${DateFormat('dd MMM').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}";
      }
    } else {
      return "${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}";
    }
  }

  @override
  Widget build(BuildContext context) {
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
                color: Theme.of(context).colorScheme.shadow,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Image
                widget.item.photoBytes != null
                    ? Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: MemoryImage(widget.item.photoBytes!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, size: 32),
                ),
                const SizedBox(width: 16.0),
                // Middle: Name above, birthdate below
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        formatTripDate(widget.item.startDate, widget.item.endDate),
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
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}