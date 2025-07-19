import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/trip_model.dart';

class PathItem extends StatefulWidget {
  const PathItem({super.key, required this.item, required this.onTap });
  final TripModel item;
  final Function(String) onTap;

  @override
  State<PathItem> createState() => _PathItemState();
}

class _PathItemState extends State<PathItem> {

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
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
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