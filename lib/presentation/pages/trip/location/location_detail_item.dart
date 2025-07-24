import 'package:flutter/material.dart';
import '../../../core/widget/common_separator.dart';

class LocationDetailItem extends StatefulWidget {
  const LocationDetailItem({super.key, required this.title, required this.description, required this.onTap });
  final String title;
  final String description;
  final GestureTapCallback? onTap;

  @override
  State<LocationDetailItem> createState() => _LocationDetailItemState();
}

class _LocationDetailItemState extends State<LocationDetailItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
              vertical: 24.0,
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    widget.onTap != null ? const Icon(Icons.copy, size: 15) : Container(),
                  ],
                ),
                const CommonSeparator(color: Colors.grey),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}