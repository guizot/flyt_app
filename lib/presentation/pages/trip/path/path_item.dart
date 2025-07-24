import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Container(
        width: 100,
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          // shape: BoxShape.circle,
          color: Theme.of(context).hoverColor,
          border: Border.all(
            color: Theme.of(context).hoverColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // location != null ? Container(
            //   width: imageSize,
            //   height: imageSize,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     image: DecorationImage(
            //       image: MemoryImage(location.photoBytes!),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ) : Container(
            //   width: imageSize,
            //   height: imageSize,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     color: Theme.of(context).colorScheme.surface,
            //   ),
            //   alignment: Alignment.center,
            //   child: const Icon(Icons.image, size: 28),
            // ),
            // const SizedBox(height: 8),
            Text(
              location != null ? location.name : "Not Found",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ],
        )
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

    LocationModel? fromLocation = widget.item.getFromLocation(widget.locations);
    LocationModel? toLocation = widget.item.getToLocation(widget.locations);
    final mode = transportModes.firstWhere((m) => m.name == widget.item.transport);
    final isBigger = mode.name.toLowerCase() == 'bus' || mode.name.toLowerCase() == 'car';

    if(widget.isEmbed) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            locationItem(fromLocation, 55),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    // Text(
                    //   mode.icon,
                    //   style: const TextStyle(fontSize: 22),
                    // ),
                    SvgPicture.asset(
                      'assets/svg/${mode.name.toLowerCase()}.svg',
                      width: isBigger ? 25: 20,
                      height: isBigger ? 25: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ?? Colors.grey,
                          BlendMode.srcIn
                      ),
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
            locationItem(toLocation, 55),
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
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    locationItem(fromLocation, 55),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // Text(
                          //   mode.icon,
                          //   style: const TextStyle(fontSize: 22),
                          // ),
                          SvgPicture.asset(
                            'assets/svg/${mode.name.toLowerCase()}.svg',
                            width: isBigger ? 25: 20,
                            height: isBigger ? 25: 20,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).iconTheme.color ?? Colors.grey,
                                BlendMode.srcIn
                            ),
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
                    locationItem(toLocation, 55),
                  ],
                ),
                const CommonSeparator(color: Colors.grey),
                Row(
                  children: [
                    blockItem('Distance', widget.item.distance),
                    const SizedBox(width: 8),
                    blockItem('Transport', widget.item.transport),
                    const SizedBox(width: 8),
                    blockItem('Est. Time', widget.item.estimatedTime),
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