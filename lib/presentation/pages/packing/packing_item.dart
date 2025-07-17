import 'package:flutter/material.dart';
import '../../../data/models/local/packing_model.dart';

class PackingItem extends StatefulWidget {
  const PackingItem({super.key, required this.item, required this.onClick, required this.onSelect });
  final Packing item;
  final Function(String) onClick;
  final Function(String) onSelect;

  @override
  State<PackingItem> createState() => _PackingItemState();
}

class _PackingItemState extends State<PackingItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onClick(widget.item.id),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(24.0)
              ),
              color: Theme.of(context).hoverColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                        onTap: () => widget.onSelect(widget.item.id),
                        child: SizedBox(
                            child: widget.item.selected ? Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  shape: BoxShape.circle
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                Icons.check,
                                size: 18,
                              ),
                            ) : Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceDim,
                                  shape: BoxShape.circle
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                Icons.check,
                                size: 18,
                                color: Colors.transparent,
                              ),
                            )
                        )
                    )
                  ],
                ),            ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          )
        ],
      )
    );
  }

}