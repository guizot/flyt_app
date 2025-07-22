import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/model/static/from_to_type.dart';
import '../../../../data/models/local/location_model.dart';
import '../../../core/widget/drop_down_item.dart';

class PathFilter extends StatefulWidget {
  final TextEditingController fromToController;
  final TextEditingController locationListController;
  final VoidCallback onFilterApplied;
  final List<LocationModel> locations;

  const PathFilter({
    super.key,
    required this.fromToController,
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
          const SizedBox(height: 4.0),
          const Text('Path Filter', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(height: 12.0),
          DropDownItem(
            title: "From To",
            controller: widget.fromToController,
            items: fromToTypes
                .map((c) => {'title': c.name, 'icon': c.icon})
                .toList(),
          ),
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
