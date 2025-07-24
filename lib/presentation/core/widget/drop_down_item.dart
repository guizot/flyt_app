import 'package:flutter/material.dart';

class DropDownItem extends StatefulWidget {
  const DropDownItem({
    super.key,
    required this.title,
    this.useValue = false,
    this.clearable = true,
    required this.controller,
    required this.items, // List<Map<String, String>>
  });

  final String title;
  final bool useValue;
  final bool clearable;
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
    _selectedTitle = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : null;
  }

  bool _isInItems(String? value) {
    if (value == null) return false;
    return widget.items.any(
      (item) => (widget.useValue ? item['value'] : item['title']) == value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            color: Theme.of(context).hoverColor,
            border: Border.all(
              color: Theme.of(context).colorScheme.shadow,
              width: 1,
            ),
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
                value: _isInItems(_selectedTitle) ? _selectedTitle : null,
                isExpanded: true,
                decoration: InputDecoration(
                  hintText: 'Select ${widget.title.toLowerCase()}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  suffixIcon:
                      _selectedTitle != null && _selectedTitle!.isNotEmpty && widget.clearable
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            setState(() {
                              _selectedTitle = null;
                              widget.controller.clear();
                            });
                          },
                        )
                      : null,
                ),
                items: widget.items.map((item) {
                  final value = item['value'] ?? '';
                  final title = item['title'] ?? '';
                  final icon = item['icon'];
                  return DropdownMenuItem<String>(
                    value: widget.useValue ? value : title,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null)
                          Text(icon, style: const TextStyle(fontSize: 18)),
                        if (icon != null) const SizedBox(width: 8),
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
        const SizedBox(height: 16),
      ],
    );
  }
}
