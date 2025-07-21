import 'package:flutter/material.dart';
import 'package:flyt_app/data/models/local/itinerary_model.dart';
import 'package:flyt_app/presentation/core/widget/common_separator.dart';
import 'package:flyt_app/presentation/pages/trip/location/location_item.dart';
import '../../../../data/models/local/location_model.dart';
import '../../../../data/models/local/path_model.dart';
import '../path/path_item.dart';

class ItineraryItem extends StatefulWidget {
  const ItineraryItem({super.key, required this.item, required this.locations, required this.paths, required this.onTap });
  final ItineraryModel item;
  final List<LocationModel> locations;
  final List<PathModel> paths;
  final Function(String) onTap;

  @override
  State<ItineraryItem> createState() => _ItineraryItemState();
}

class _ItineraryItemState extends State<ItineraryItem> {

  Widget locationItem (LocationModel? location) {
    if(location != null) {
      return LocationItem(item: location, onTap: (id) {}, isEmbed: true);
    }
    return Container();
  }

  Widget pathItem (PathModel? path) {
    if(path != null) {
      return PathItem(item: path, onTap: (id) {}, locations: widget.locations, isEmbed: true);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    LocationModel? location = widget.item.getLocation(widget.locations);
    PathModel? path = widget.item.getPath(widget.paths);
    
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.time,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  widget.item.type,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.surface
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.item.description,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                  ],
                ),
                (location != null || path != null) ? const CommonSeparator(color: Colors.grey) : Container(),
                locationItem(location),
                pathItem(path)
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

}