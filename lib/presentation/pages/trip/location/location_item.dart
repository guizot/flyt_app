import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/location_model.dart';
import 'package:flyt_app/presentation/core/widget/common_separator.dart';

class LocationItem extends StatefulWidget {
  const LocationItem({super.key, required this.item, required this.onTap,  this.isEmbed = false });
  final LocationModel item;
  final Function(String) onTap;
  final bool isEmbed;

  @override
  State<LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {

  @override
  Widget build(BuildContext context) {
    if(widget.isEmbed) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Image
            widget.item.photoBytes != null
                ? Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: MemoryImage(widget.item.photoBytes!),
                  fit: BoxFit.cover,
                ),
              ),
            )
                : Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.surface,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.person, size: 32),
            ),
            const SizedBox(width: 24.0),
            // Middle: Name above, birthdate below
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    widget.item.type,
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
          ],
        );
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
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left: Image
                    widget.item.photoBytes != null
                        ? Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: MemoryImage(widget.item.photoBytes!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                            widget.item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.item.type,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
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
                const CommonSeparator(color: Colors.grey),
                Text(
                  widget.item.address,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}