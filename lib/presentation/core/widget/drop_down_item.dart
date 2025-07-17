import 'package:flutter/material.dart';

class DropDownItem extends StatefulWidget {
  const DropDownItem({
    super.key,
    required this.title,
    required this.controller,
    required this.items, // List<Map<String, String>>
  });

  final String title;
  final TextEditingController controller;
  final List<Map<String, String>> items;

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  Map<String, String>? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize the selected value from the controller if available
    final match = widget.items.where(
      (item) => item['title'] == widget.controller.text,
    );
    if (match.isNotEmpty) {
      _selectedValue = match.first;
    } else {
      _selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipPath(
          clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Theme.of(context).hoverColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_circle_right_rounded, size: 18),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                  ],
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<Map<String, String>>(
                  value: _selectedValue,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: 'Select ${widget.title.toLowerCase()}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  items: widget.items
                      .map(
                        (item) => DropdownMenuItem<Map<String, String>>(
                          value: item,
                          child: Row(
                            children: [
                              if (item['icon'] != null)
                                Text(
                                  item['icon']!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              if (item['icon'] != null)
                                const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item['title'] ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                      widget.controller.text = value?['title'] ?? '';
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
