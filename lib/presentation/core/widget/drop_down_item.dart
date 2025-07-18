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
  String? _selectedTitle;

  @override
  void initState() {
    super.initState();
    _selectedTitle = widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipPath(
          clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                  ],
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedTitle,
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
                  items: widget.items.map((item) {
                    final title = item['title'] ?? '';
                    final icon = item['icon'];
                    return DropdownMenuItem<String>(
                      value: title,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null)
                            Text(icon, style: const TextStyle(fontSize: 18)),
                          if (icon != null)
                            const SizedBox(width: 8),
                          Expanded(
                            child: Text(title, overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTitle = value;
                      widget.controller.text = value ?? '';
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
