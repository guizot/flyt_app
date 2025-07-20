import 'package:flutter/material.dart';

import '../../../../data/models/local/location_model.dart';
import '../../../../data/models/local/path_model.dart';
import '../../../core/model/common/itinerary_group.dart';
import 'itinerary_item.dart';

class ItineraryGroupItem extends StatefulWidget {
  final List<ItineraryGroup> groups;
  final void Function(String) onTap;
  final List<LocationModel> locations;
  final List<PathModel> paths;

  const ItineraryGroupItem({
    super.key,
    required this.groups,
    required this.onTap,
    required this.locations,
    required this.paths,
  });

  @override
  State<ItineraryGroupItem> createState() => _ItineraryGroupItemState();
}

class _ItineraryGroupItemState extends State<ItineraryGroupItem> {
  final Map<String, bool> _expandedGroups = {};

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: widget.groups.length,
      itemBuilder: (context, index) {
        final group = widget.groups[index];
        final isExpanded = _expandedGroups[group.date] ?? true;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DATE HEADER
            GestureDetector(
              onTap: () {
                setState(() {
                  _expandedGroups[group.date] = !isExpanded;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 18),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        group.date,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(isExpanded ? Icons.expand_less : Icons.expand_more)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            if (isExpanded)
              ...group.items.map(
                    (itinerary) => ItineraryItem(
                  item: itinerary,
                  onTap: widget.onTap,
                  locations: widget.locations,
                  paths: widget.paths,
                ),
              ),

            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
