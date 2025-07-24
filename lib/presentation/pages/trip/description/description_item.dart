import 'package:flutter/material.dart';
import '../../../core/widget/common_separator.dart';

class DescriptionItem extends StatefulWidget {
  const DescriptionItem({
    super.key,
    required this.title,
    this.separator = true,
    required this.child,
    this.onTap,
  });
  final String title;
  final bool separator;
  final Widget child;
  final VoidCallback? onTap;

  @override
  State<DescriptionItem> createState() => _DescriptionItemState();
}

class _DescriptionItemState extends State<DescriptionItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              color: Theme.of(context).hoverColor,
              border: Border.all(
                color: Theme.of(context).colorScheme.shadow,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                widget.separator ? const CommonSeparator(color: Colors.grey) : Container(),
                widget.separator ? Container() : const SizedBox(height: 16.0),
                widget.child
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      )
    );
  }

}