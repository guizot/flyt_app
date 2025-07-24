import 'package:flutter/material.dart';
import '../../../../data/models/local/location_model.dart';
import '../../../core/widget/drop_down_item.dart';

class PathFilter extends StatefulWidget {
  final TextEditingController locationListController;
  final VoidCallback onFilterApplied;
  final List<LocationModel> locations;

  const PathFilter({
    super.key,
    required this.locationListController,
    required this.onFilterApplied,
    required this.locations
  });

  @override
  State<PathFilter> createState() => _PathFilterState();
}

class _PathFilterState extends State<PathFilter> {

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
            'Path Filter',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          DropDownItem(
            title: "Location",
            controller: widget.locationListController,
            useValue: true,
            items: widget.locations
                .map((loc) => {'title': loc.name, 'value': loc.id})
                .toList()
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
