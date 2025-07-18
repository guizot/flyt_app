import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/trip_model.dart';

class TripItem extends StatefulWidget {
  const TripItem({super.key, required this.item, required this.onTap });
  final TripModel item;
  final Function(String) onTap;

  @override
  State<TripItem> createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {

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
              // border: Border.all(
              //   color: Colors.grey, // or any color you want
              //   width: 0.5, // border width
              // ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Image
                widget.item.photoBytes != null
                    ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: MemoryImage(widget.item.photoBytes!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(
                  width: 100,
                  height: 100,
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
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "${widget.item.startDate} - ${widget.item.endDate}",
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