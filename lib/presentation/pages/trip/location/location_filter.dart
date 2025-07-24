import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/model/static/location_types.dart';
import '../../../core/widget/drop_down_item.dart';

class LocationFilter extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onFilterApplied;
  final List<LocationType> usedLocationTypes;

  const LocationFilter({
    super.key,
    required this.controller,
    required this.onFilterApplied,
    required this.usedLocationTypes,
  });

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
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
            'Location Filter',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          DropDownItem(
            title: "Location Type",
            controller: widget.controller,
            items: widget.usedLocationTypes
                .map((c) => {'title': c.name, 'icon': c.icon})
                .toList(),
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