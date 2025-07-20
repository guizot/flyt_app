import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/location_model.dart';
import 'package:flyt_app/data/models/local/path_model.dart';
import 'package:flyt_app/presentation/core/widget/common_separator.dart';
import '../../../core/model/static/transport_mode.dart';

class PathItem extends StatefulWidget {
  const PathItem({super.key, required this.item, required this.locations, required this.onTap, this.isEmbed = false });
  final PathModel item;
  final List<LocationModel> locations;
  final Function(String) onTap;
  final bool isEmbed;

  @override
  State<PathItem> createState() => _PathItemState();
}

class _PathItemState extends State<PathItem> {

  Widget locationItem (LocationModel? location, double imageSize) {
    return Expanded(
        flex: 1,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              color: Theme.of(context).hoverColor,
            ),
            child: Column(
              children: [
                location != null ? Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: MemoryImage(location.photoBytes!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ) : Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  location != null ? location.name : "Location Not Found",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            )
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    LocationModel? fromLocation = widget.item.getFromLocation(widget.locations);
    LocationModel? toLocation = widget.item.getToLocation(widget.locations);
    final mode = transportModes.firstWhere((m) => m.name == widget.item.transport);

    if(widget.isEmbed) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationItem(fromLocation, 50),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      mode.icon,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const dashWidth = 6.0;
                        const dashSpace = 4.0;
                        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(dashCount, (_) {
                            return Container(
                              width: dashWidth,
                              height: 1,
                              color: Colors.grey,
                            );
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.estimatedTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                )
            ),
            locationItem(toLocation, 50),
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
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    locationItem(fromLocation, 60),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            mode.icon,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 12),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              const dashWidth = 6.0;
                              const dashSpace = 4.0;
                              final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(dashCount, (_) {
                                  return Container(
                                    width: dashWidth,
                                    height: 1,
                                    color: Colors.grey,
                                  );
                                }),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.item.estimatedTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      )
                    ),
                    locationItem(toLocation, 60),
                  ],
                ),
                const CommonSeparator(color: Colors.grey),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                            color: Theme.of(context).hoverColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Distance',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                    fontSize: 13
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.item.distance,
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
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                            color: Theme.of(context).hoverColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Transport',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                    fontSize: 13
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.item.transport,
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
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                            color: Theme.of(context).hoverColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Est. Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.item.estimatedTime,
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
                    ),
                  ],
                )
              ],
            )
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}