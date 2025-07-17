import 'package:flutter/material.dart';

import 'common_separator.dart';

class CommonItem extends StatefulWidget {
  const CommonItem({super.key, required this.title, required this.icon, required this.child, this.timestamp });
  final String title;
  final IconData icon;
  final Widget child;
  final String? timestamp;

  @override
  State<CommonItem> createState() => _CommonItemState();
}

class _CommonItemState extends State<CommonItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipPath(
            clipper: const ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                )
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        size: 18,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600
                            ),
                          )
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  ),

                  const CommonSeparator(
                    color: Colors.grey,
                  ),

                  widget.child
                ],
              ),
            )
        ),
        const SizedBox(height: 16),
      ],
    );
  }

}